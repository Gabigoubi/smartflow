# Projeto Integrador: Gerador De Leads

Sistema para resolver o gap de sincronização entre leads de revisão e agendamentos reais, utilizando uma arquitetura de microsserviços.

## Checklist de Desenvolvimento

### Fase 1: Data Modeling (Modelagem do Ambiente)
- [✓] Criar repositório privado no GitHub.
- [✓] Escrever script `schema.sql` (Tabelas: Clientes, Agendamentos, Leads).
- [✓] Criar `docker-compose.yml` para subir o PostgreSQL no PC.
- [✓] Popular banco com massa de teste inicial.

### Fase 2: Java-API (O Core do Negócio)
- [✓] Setup do projeto Spring Boot (JPA, Postgres Driver, Web).
- [✓] Mapear as Entities `Cliente` e `Agendamento`.
- [✓] Criar os Repositories (`CustomerRepository` e `AppointmentRepository`).
- [✓] Implementar Controller com `POST /agendamentos` e Injeção de Dependência.

### Fase 3: Go-Worker (O Motor de Inteligência e Logs)
- [✓] Setup do projeto Go e conexão com Postgres (`main.go` e `go.mod`).
- [✓] Construir a Query de Filtro Inteligente avançada (Unir `NOT EXISTS` agendamento ativo + Validação de revisão nos últimos 90 dias).
- [✓] Implementar o motor de varredura no Go com as regras de negócio.
- [✓] Implementar sistema de Logs Visuais no terminal para o teste de gravação:
  - *Log: "Cliente [X] já tem revisão agendada -> IGNORADO"*
  - *Log: "Cliente [X] já fez revisão há 90 dias -> IGNORADO"*
  - *Log: "Cliente [X] elegível -> LEAD CRIADO COM SUCESSO"*
- [✓] Implementar proteção contra duplicidade (verificar tabela de leads nas últimas 24h).

### Fase 4: Mensageria (Integração Telegram & Rate Limit)
- [✓] Criar Bot no Telegram via `@BotFather` e obter Token.
- [✓] Criar rotina em Go para disparar mensagens HTTP para a API do Telegram.
- [✓] Implementar o `time.Ticker` (100ms) para criar um gargalo de segurança (Rate Limit de 10 leads/segundo) protegendo a API do Telegram.

### Fase 5: Validação de QA e Stress Test (Gravação)
- [ ] Injetar 300 clientes simulados no banco de dados para o Stress Test.
- [ ] Executar o Flow Positivo e Negativo (garantir que os bloqueios estão funcionando e printando no log).
- [ ] Gravação Final: Rodar o projeto capturando o scroll do terminal no PC e a chegada simultânea em massa dos Leads no celular.

---

## Stack Técnica
* **Database:** PostgreSQL + Docker
* **Backend A:** Java + Spring Boot (Simulação de sistema de gestão)
* **Backend B:** Golang (Processamento de alta performance e concorrência)
* **Notificação:** Telegram Bot API
