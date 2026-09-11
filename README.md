# FieldTech Engineering Challenge — MOTIVA / CCR
## 3º Entregável — Data Science & SQL Aplicado (Sprint 3)

---

## 👥 Integrantes do Grupo
* **Nome:** Gabriel Bastos Nhoncanse — **RM:** [562022]

---

## 📌 Contexto do Projeto
No âmbito do desafio **MOTIVA / CCR**, o monitoramento de infraestrutura e das condições das áreas periféricas de terminais e rodovias é fundamental para a segurança, fluidez operacional e preservação do patrimônio. 

O acúmulo de vegetação descontrolada nos cantos de plataformas, canteiros laterais, acostamentos e taludes pode comprometer a visibilidade de motoristas, causar danos estruturais ao pavimento e aumentar custos com intervenções de emergência.

Nesta 3ª Sprint, estruturamos um banco de dados relacional no **PostgreSQL** focado em mapear as características físicas dos locais (inclinações, tipo de pavimento, área em metros quadrados) e cruzar com os registros de ocorrências de vegetação. O objetivo é transformar dados brutos em inteligência operacional para tomada de decisão em manutenção preventiva e alocação de recursos.

---

## 🗄️ Estrutura do Banco de Dados

O banco de dados é composto por duas tabelas principais relacionadas via chave estrangeira (`FK`):

### 1. Tabela `locais`
Armazena a caracterização dos pontos e setores monitorados nos terminais/rodovias.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `id_local` | `INT (PRIMARY KEY)` | Identificador único do local/ponto. |
| `nome_terminal` | `VARCHAR(100)` | Nome do terminal ou trecho rodoviário. |
| `setor` | `VARCHAR(100)` | Canto ou setor específico (ex: Canto Leste, Acostamento Norte). |
| `tipo_pavimento` | `VARCHAR(50)` | Tipo de solo (ex: Paralelepípedo, Terra, Asfalto). |
| `dificuldade_acesso` | `VARCHAR(20)` | Nível de acesso (Fácil, Médio, Difícil). |
| `inclinacao` | `VARCHAR(30)` | Relevo da área (Plano, Inclinação Leve, Talude/Barranco). |
| `area_m2` | `DECIMAL(10,2)` | Área total do setor monitorado. |

### 2. Tabela `vegetacao_registros`
Armazena as vistorias e medições de crescimento vegetal efetuadas em cada local.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `id_registro` | `INT (PRIMARY KEY)` | Identificador único da vistoria. |
| `id_local` | `INT (FOREIGN KEY)` | Chave estrangeira que referencia `locais(id_local)`. |
| `altura_cm` | `DECIMAL(6,2)` | Altura medida da vegetação em centímetros. |
| `tipo_vegetacao` | `VARCHAR(50)` | Tipo da planta (ex: Matagal, Gramínea, Arbusto). |
| `nivel_obstrucao` | `VARCHAR(20)` | Classificação de risco (Baixo, Médio, Alto). |
| `custo_poda` | `DECIMAL(10,2)` | Custo estimado ou executado para poda/roçagem (R$). |
| `data_vistoria` | `DATE` | Data em que a medição foi realizada. |

---

## 🔍 Consultas SQL & Análise dos Resultados

---

### Pergunta 1: Ocorrências de Vegetação por Tipo de Pavimento
* **Objetivo:** Quantificar quantos registros de vegetação existem cadastrados para cada tipo de pavimento (`tipo_pavimento`).
* **Conceitos Utilizados:** `GROUP BY`, `COUNT`.

```sql
SELECT 
    l.tipo_pavimento,
    COUNT(r.id_registro) AS total_ocorrencias
FROM locais l
LEFT JOIN vegetacao_registros r ON l.id_local = r.id_local
GROUP BY l.tipo_pavimento
ORDER BY total_ocorrencias DESC;
