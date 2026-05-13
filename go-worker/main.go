package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

func main() {
	
	connStr := "user=root password=root dbname=concessionaria_db host=5432 port=5432 sslmode=disable"

	
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal("Erro fatal ao configurar o banco: ", err)
	}
	defer db.Close() 
	
	err = db.Ping()
	if err != nil {
		log.Fatal("O banco não respondeu ao chamado: ", err)
	}

	fmt.Println("Conexão com o PostgreSQL estabelecida com sucesso! O Motor Go está online.")
}
