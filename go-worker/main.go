func runWorker(db *sql.DB) {
	ticker := time.NewTicker(1 * time.Minute)
	defer ticker.Stop()

	for range ticker.C {
		fmt.Println("Buscando clientes....")
		query := `
		SELECT c.id, c.name, a.status, a.schedule_date
		FROM customers c
		LEFT JOIN appointments a ON c.id = a.customer_id
		`
		rows, err := db.Query(query)
		if err != nil {
			fmt.Println("Erro ao buscar no banco: ", err)
			continue
		}

		for rows.Next() {
			var id int
			var name string
			var status sql.NullString
			var scheduleDate sql.NullTime

			err := rows.Scan(&id, &name, &status, &scheduleDate)
			if err != nil {
				fmt.Println("Erro ao extrair dados da linha: ", err)
				continue
			}

			days := int(time.Since(scheduleDate.Time).Hours() / 24)

			if status.Valid && status.String == "ABERTO" {
				fmt.Printf("Cliente [%s] já tem revisão agendada -> IGNORADO\n", name)
				continue
			}

			if scheduleDate.Valid && days <= 90 {
				fmt.Printf("Cliente [%s] já tem agendamento em menos de 90 dias -> IGNORADO\n", name)
				continue
			}

			var leadExist bool
			err = db.QueryRow("SELECT EXISTS(SELECT 1 FROM leads WHERE customer_id = $1)", id).Scan(&leadExist)
			if err != nil {
				fmt.Println("Erro ao checar lead duplicado: ", err)
				continue
			}

			if leadExist {
				fmt.Printf("Cliente [%s] já possui um lead ativo -> IGNORADO\n", name)
				continue
			}

			fmt.Printf("Cliente [%s] elegível -> LEAD CRIADO COM SUCESSO\n", name)

			time.Sleep(100 * time.Millisecond)

			_, err = db.Exec("INSERT INTO leads (customer_id, created_at) VALUES ($1, NOW())", id)
			if err != nil {
				fmt.Println("Erro ao salvar lead no banco: ", err)
			}
		}
		
		rows.Close()
	}
}
