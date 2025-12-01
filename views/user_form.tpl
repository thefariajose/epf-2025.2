% rebase('layout.tpl', title='Usuário')

<style>
    /* CSS Específico para o Checkbox */
    .checkbox-group {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 6px;
        border: 1px solid #e9ecef;
        margin-bottom: 20px;
    }

    .checkbox-label {
        display: flex;
        align-items: flex-start;
        cursor: pointer;
        gap: 10px;
    }

    .checkbox-label input {
        margin-top: 4px;
        transform: scale(1.2);
        cursor: pointer;
    }

    .checkbox-text strong {
        display: block;
        color: #2c3e50;
        font-size: 15px;
    }

    .checkbox-text small {
        display: block;
        color: #7f8c8d;
        font-size: 13px;
        margin-top: 2px;
    }

    /* CSS para mensagem de erro */
    .error-message {
        background-color: #ffe5e5;
        color: #c0392b;
        padding: 12px;
        border-radius: 6px;
        margin-bottom: 20px;
        border: 1px solid #f5c6cb;
        font-size: 14px;
    }
</style>

<section class="form-section">

    <div class="form-container-box modern-box">

        <div class="form-header">
            <h1><i class="fas fa-user"></i> {{ 'Editar Usuário' if user else 'Novo Usuário' }}</h1>
            <p>Gerencie contas do sistema.</p>
        </div>

        % if defined('error') and error:
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> {{error}}
        </div>
        % end
        <form action="{{ '/users/edit/' + str(user.id) if user else '/users/add' }}" method="post">

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required 
                       value="{{ user.email if user else '' }}" 
                       placeholder="email@exemplo.com">
            </div>

            <div class="form-group">
                <label>Senha</label>
                <input type="password" name="password" 
                       placeholder="{{ 'Deixe em branco para não alterar' if user else 'Digite a senha' }}">
            </div>

            <div class="checkbox-group">
                <label class="checkbox-label">
                    <input type="checkbox" name="is_locador" 
                    {{'checked' if user and user.is_locador else ''}}>
                    
                    <div class="checkbox-text">
                        <strong>Sou Locador</strong>
                        <small>Marque esta opção para cadastrar veículos e gerenciar aluguéis.</small>
                    </div>
                </label>
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i> Salvar
            </button>

        </form>

    </div>

</section>