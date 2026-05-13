# Projeto Integrador: Gerador De Leads

Sistema para resolver o gap de sincronização entre leads de revisão e agendamentos reais, utilizando uma arquitetura de microsserviços.

## Checklist de Desenvolvimento

### Fase 1: Data Modeling (Modelagem do Ambiente)
- [✓] Criar repositório privado no GitHub.
- [✓] Escrever script `schema.sql` (Tabelas: Clientes, Agendamentos, Leads).
- [✓] Criar `docker-compose.yml` para subir o PostgreSQL no PC.
- [✓] Popular banco com massa de teste (clientes com e sem agendamento).

### Fase 2: Java-API (O Core do Negócio)
- [✓] Setup do projeto Spring Boot (JPA, Postgres Driver, Web).
- [✓] Mapear as Entities `Cliente` e `Agendamento`.
- [✓] Criar os Repositories.
- [✓] Implementar Controller com `POST /agendamentos` (Status: ABERTO).

### Fase 3: Go-Worker (O Motor de Inteligência)
- [ ] Setup do projeto Go e conexão com Postgres.
- [ ] Implementar a Query de Filtro Inteligente (`NOT EXISTS`).
- [ ] Criar o `time.Ticker` para rodar o processo periodicamente.
- [ ] Implementar lógica para evitar duplicidade de leads (verificar últimas 24h).

### Fase 4: Mensageria (Prova de Conceito)
- [ ] Criar Bot no Telegram via `@BotFather`.
- [ ] Implementar função de disparo no Go usando a API do Telegram.
- [ ] Testar recebimento da notificação no celular.

### Fase 5: Validação (QA)
- [ ] Teste de Fluxo Positivo: Criar agendamento e validar que o Go NÃO gera lead.
- [ ] Teste de Fluxo Negativo: Deletar agendamento e validar geração de lead imediata.
- [ ] Simulação de "Uso Real" com múltiplos registros.

---

## Stack Técnica
*   **Database:** PostgreSQL + Docker
*   **Backend A:** Java + Spring Boot (Simulação de sistema de gestão)
*   **Backend B:** Golang (Processamento de alta performance e concorrência)
*   **Notificação:** Telegram Bot API