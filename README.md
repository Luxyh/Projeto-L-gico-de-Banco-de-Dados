# 🛒 Projeto SQL – E-commerce (Desafio de Modelagem e Consultas)

## 📘 Descrição do Projeto
Este projeto implementa um **banco de dados relacional para um sistema de e-commerce**, seguindo as diretrizes de modelagem conceitual e lógica propostas no desafio.  
O objetivo é aplicar conceitos de **normalização, chaves primárias/estrangeiras, constraints, relacionamentos EER e consultas SQL avançadas**.

---

## 🧱 Estrutura do Banco de Dados
O modelo contempla os principais elementos de um e-commerce realista:

- **Cliente** – dados genéricos de clientes.
- **Cliente_PF** e **Cliente_PJ** – especializações (Pessoa Física e Jurídica).
- **Produto** – catálogo de itens vendidos.
- **Fornecedor** – entidades que fornecem produtos.
- **Terceiro_Vendedor** – vendedores externos que oferecem produtos via marketplace.
- **Estoque** – controle de disponibilidade dos produtos.
- **Pedido** – registros de compras realizadas pelos clientes.
- **ItemPedido** – relação N:N entre Pedido e Produto.
- **Entrega** – status e rastreio de pedidos.
- **Pagamento** – métodos e status de pagamento.
- **Forma_Pagamento** – cadastro de opções aceitas (cartão, pix, boleto etc.).

---

## ⚙️ Regras de Negócio e Constraints Importantes

- `idCliente` → `AUTO_INCREMENT`, `PRIMARY KEY`, `NOT NULL`
- `CPF` → `UNIQUE`, `NOT NULL`
- `RazaoSocial` → `UNIQUE`, `NOT NULL`
- `Nome`, `DataNascimento`, `idPedido`, `idTerceiro_Vendedor` → `NOT NULL`
- `Status` de Produto → `ENUM('Disponivel', 'Sem estoque')`
- `StatusPedido` → `ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue')`

---

## 🧩 Relacionamentos Principais

- Um **Cliente** pode fazer vários **Pedidos**.  
- Um **Pedido** pode conter vários **Produtos**.  
- Um **Produto** pode ser vendido por um **Fornecedor** ou **Terceiro_Vendedor**.  
- Um **Pedido** possui uma **Entrega** e um ou mais **Pagamentos**.

---

## 💾 Estrutura do Script
O arquivo SQL completo inclui:

1. **Criação do esquema** (CREATE DATABASE / CREATE TABLE)  
2. **Inserção de dados de teste** (INSERT INTO)  
3. **Consultas SQL com múltiplos recursos**:
   - Recuperações simples (`SELECT`)
   - Filtros (`WHERE`)
   - Atributos derivados (`CONCAT`, `DATEDIFF`, cálculos)
   - Ordenações (`ORDER BY`)
   - Agrupamentos e condições (`GROUP BY`, `HAVING`)
   - Junções complexas (`JOIN`)

---

## 🔍 Exemplos de Consultas

- Quantos pedidos foram feitos por cada cliente?
- Algum vendedor também é fornecedor?
- Relação entre produtos, fornecedores e estoques.
- Relação entre nomes de fornecedores e produtos fornecidos.
- Listar produtos vendidos por terceiros.
- Pedidos com valor total acima de uma faixa específica.

---

## ▶️ Execução

1. Execute o script `.sql` no **MySQL Workbench**.  
2. O banco será criado automaticamente com dados de teste.  
3. Rode as consultas no final do arquivo para validar os resultados.  

---

## 🧠 Aprendizados e Habilidades Desenvolvidas

- Modelagem ER e EER com MySQL Workbench  
- Criação de chaves primárias, estrangeiras e constraints  
- Aplicação de tipos `ENUM`, `AUTO_INCREMENT`, `UNIQUE` e `NOT NULL`  
- Escrita de queries SQL intermediárias e avançadas  
- Interpretação de relacionamentos e refinamento de modelo conceitual  

---

## 🧑‍💻 Autor
**Luiz Henrique**  
Estudante de Engenharia Mecânica | Transição para Data Science e Engenharia de Dados  
📊 Foco em análise e modelagem de dados com SQL, Python e Power BI.  
