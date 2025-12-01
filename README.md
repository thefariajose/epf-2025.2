# 🚗 CarRENT: Sistema de Aluguel de Veículos

Este é um projeto de sistema de gerenciamento e solicitação de aluguel de veículos, desenvolvido em **Python** utilizando o framework **Bottle**. O sistema é segue o padrão **MVC (Model-View-Controller)** e utiliza arquivos **JSON** para persistência de dados.

O foco foi no desenvolvimento de uma interface de usuário clara e intuitiva para Locadores e Clientes.

---

## 💻 Estrutura do Projeto

A arquitetura do projeto é dividida em módulos bem definidos, facilitando a manutenção e a aplicação dos princípios de Orientação a Objetos.

| Pasta/Módulo | Descrição |
| :--- | :--- |
| **`controllers/`** | Responsável por receber as requisições (rotas) e coordenar a interação entre o Modelo e o Serviço, preparando os dados para a `view`. |
| **`models/`** | Contém as classes de entidades do sistema (`Cliente`, `Locador`, `Veiculo`, `Locacao`), aplicando os conceitos de POO. |
| **`services/`** | Contém a lógica de negócio principal, a validação de dados e o controle da persistência (leitura/escrita dos arquivos JSON). |
| **`data/`** | Armazena todos os dados da aplicação em formato JSON (ex: `clientes.json`, `veiculos.json`, `locacoes.json`). |
| **`views/`** | Contém os templates HTML da aplicação (`.tpl`), renderizados pelo framework Bottle. |
| **`static/`** | Contém os arquivos estáticos (CSS, JS, Imagens) que definem o visual do sistema. |

---

## ✨ Funcionalidades Chave

### 👤 Cliente
* **Vitrine:** Visualização de todos os veículos disponíveis para locação.
* **Solicitação de Aluguel:** Envio de pedidos de locação com período de data.
* **Meus Aluguéis:** Acompanhamento do status dos pedidos (*Em Negociação*, *Alugado*, *Cancelado*).

### 💼 Locador
* **Painel de Controle:** Visualização de todas as solicitações de aluguel pendentes.
* **Gestão de Frota:** Cadastro, edição e remoção de veículos.
* **Aprovação/Rejeição:** Resposta direta e gerenciamento das solicitações de locação.

---

## ⚙️ Configuração e Instalação

### 1. Pré-requisitos
* **Python 3.x**
* **pip** (Gerenciador de pacotes do Python)

### 2. Instalar Dependências

Instale todas as bibliotecas necessárias listadas no `requirements.txt`:

```bash
pip install -r requirements.txt