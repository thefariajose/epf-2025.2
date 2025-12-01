% rebase('layout.tpl', title='Gerenciar Veículo')

<style>
    
    /* Contêiner de formulário centralizado */
    .form-page-wrapper {
        display: flex;
        justify-content: center;
        padding: 30px 20px;
    }

    /* Caixa do Formulário */
    .form-container-box {
        max-width: 600px;
        width: 100%;
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        border-top: 5px solid var(--accent-color); /* Destaque Laranja */
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

    /* Mensagem de Erro (Padronizada) */
    .error-message {
        background-color: #ffe5e5;
        color: #c0392b; /* Vermelho Escuro */
        padding: 12px;
        border-radius: 6px;
        margin-bottom: 20px;
        border: 1px solid #f5c6cb;
        font-size: 0.95rem;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    /* Botão de Submissão (Salvar) */
    .btn-submit {
        background-color: var(--primary-color); /* Azul Marinho */
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

    .btn-submit:hover {
        background-color: var(--secondary-color);
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

    /* Estilo para flexbox interno */
    .form-row {
        display: flex; 
        gap: 15px;
        margin-bottom: 20px;
    }

    .form-group {
        flex: 1; /* Garante que os grupos dentro do form-row dividam o espaço */
        margin-bottom: 20px; /* Mantido para grupos que não estão em linhas flex */
    }
    
    /* Supondo que você tenha estilos básicos para input e label no style.css: */
    /*
    .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #555; }
    .form-group input { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
    */
</style>

<div class="form-page-wrapper">
    <div class="form-container-box">
        <div class="form-header">
            <h1>
                <i class="fas fa-car"></i> 
                {{'Editar Veículo' if veiculo else 'Novo Veículo'}}
            </h1>
            <p>Preencha os dados da frota</p>
        </div>

        % if defined('error') and error:
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> {{error}}
        </div>
        % end
        
        <form action="{{action}}" method="post">
            
            <div class="form-row">
                <div class="form-group">
                    <label>Placa</label>
                    <input type="text" name="placa" required 
                           value="{{veiculo.placa if veiculo else ''}}" placeholder="ABC-1234">
                </div>
                <div class="form-group">
                    <label>Marca</label>
                    <input type="text" name="marca" required 
                           value="{{veiculo.marca if veiculo else ''}}" placeholder="Ex: Fiat">
                </div>
            </div>

            <div class="form-group">
                <label>Modelo</label>
                <input type="text" name="modelo" required 
                       value="{{veiculo.modelo if veiculo else ''}}" placeholder="Ex: Uno Mille">
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Ano</label>
                    <input type="number" name="ano" required 
                           value="{{veiculo.ano if veiculo else ''}}" placeholder="2020">
                </div>
                <div class="form-group">
                    <label>Quilometragem</label>
                    <input type="number" name="quilometragem" required 
                           value="{{veiculo.quilometragem if veiculo else ''}}" placeholder="0">
                </div>
            </div>

            <div class="form-group">
                <label>Preço da Diária (R$)</label>
                <input type="number" step="0.01" name="preco_diaria" required 
                       value="{{veiculo.preco_diaria if veiculo else ''}}" placeholder="100.00">
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i> Salvar
            </button>
            
            <div style="text-align: center; margin-top: 15px;">
                <a href="/dashboard-locador" class="action-link">Cancelar</a>
            </div>
        </form>
    </div>
</div>