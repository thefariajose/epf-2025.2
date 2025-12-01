% rebase('layout.tpl', title='Solicitar Aluguel')

<style>
    /* -----------------------------------------
       ESTILOS ESPECÍFICOS DO FORMULÁRIO DE SOLICITAÇÃO
    ----------------------------------------- */
    
    /* Contêiner de formulário centralizado (reutilizando a classe do template anterior) */
    .form-page-wrapper {
        display: flex;
        justify-content: center;
        padding: 30px 20px;
    }

    /* Caixa do Formulário (reutilizando a classe do template anterior) */
    .form-container-box {
        max-width: 600px;
        width: 100%;
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        border-top: 5px solid var(--accent-color); 
    }

    /* Cabeçalho do Formulário */
    .form-header {
        text-align: center;
        margin-bottom: 30px;
    }

    .form-header h1 {
        color: var(--primary-color);
        font-size: 2rem;
        margin-bottom: 5px;
    }

    .form-header p {
        color: #777;
        font-size: 1rem;
    }

    /* Destaque para o Preço da Diária */
    .price-highlight {
        color: var(--success-color, #27ae60); /* Verde para preços */
        font-weight: bold;
        font-size: 1.1rem;
    }

    /* Bloco de Informação/Atenção */
    .info-block {
        background: #e8f4fd; /* Azul Claro Suave */
        padding: 15px;
        border-radius: 6px;
        color: var(--primary-color); 
        font-size: 0.95em;
        margin-bottom: 20px;
        border-left: 5px solid var(--secondary-color); /* Linha Azul Forte */
        display: flex;
        gap: 10px;
        align-items: flex-start;
    }
    
    /* Botão de Submissão (Enviar Solicitação) - Laranja/Accent */
    .btn-submit-accent {
        background-color: var(--accent-color);
        color: white;
        padding: 12px 20px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        font-size: 1rem;
        width: 100%;
        transition: background-color 0.2s;
        margin-top: 10px;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .btn-submit-accent:hover {
        background-color: #d35400; /* Laranja mais escuro */
    }
    
    /* Links de Ação (Cancelar) */
    .action-link {
        color: #777;
        text-decoration: none;
        transition: color 0.2s;
        font-weight: 500;
    }

    .action-link:hover {
        color: var(--accent-color);
    }

    /* Estilo para flexbox interno (reutilizando a classe do template anterior) */
    .form-row {
        display: flex; 
        gap: 15px;
        margin-bottom: 20px;
    }

    .form-group {
        flex: 1; 
        margin-bottom: 20px;
    }
    
    /* Estilo para inputs de data (garante que ocupem 100% do grupo) */
    .form-group input[type="date"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
</style>

<div class="form-page-wrapper">
    <div class="form-container-box">
        <div class="form-header">
            <h1><i class="fas fa-calendar-check"></i> Alugar Veículo</h1>
            <p>Você está solicitando: <strong>{{veiculo.modelo}}</strong> ({{veiculo.marca}})</p>
            <p class="price-highlight">Diária base: R$ {{veiculo.preco_diaria}}</p>
        </div>

        <form action="/cliente/alugar/{{veiculo.id}}" method="post">
            
            <div class="form-row">
                <div class="form-group">
                    <label>Data de Início</label>
                    <input type="date" name="data_inicio" required id="inicio">
                </div>
                <div class="form-group">
                    <label>Data de Fim</label>
                    <input type="date" name="data_fim" required id="fim">
                </div>
            </div>

            <div class="info-block">
                <div><i class="fas fa-info-circle"></i></div>
                <div>
                    <strong>Atenção:</strong> O valor total será calculado automaticamente incluindo o período selecionado + taxa de serviço de 30%. O pedido ficará **"Em Negociação"** até o locador aceitar.
                </div>
            </div>

            <button type="submit" class="btn-submit-accent">
                <i class="fas fa-paper-plane"></i> Enviar Solicitação
            </button>
            
            <div style="text-align: center; margin-top: 15px;">
                <a href="/cliente/vitrine" class="action-link">Cancelar</a>
            </div>
        </form>
    </div>
</div>