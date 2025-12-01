% rebase('layout.tpl', title='Gerenciar Usuário')

<style>
    /* ------- Variáveis Locais (caso não estejam no global ainda) ------- */
    :root {
        --primary-color: #163b65; /* Azul Marinho */
        --accent-color: #e67e22;  /* Laranja */
    }

    /* ------- Estilo do Checkbox Personalizado ------- */
    .checkbox-group {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 8px;
        border: 1px solid #e9ecef;
        margin-bottom: 25px;
        transition: all 0.2s ease;
        position: relative;
    }

    /* Efeito de hover no bloco do checkbox */
    .checkbox-group:hover {
        border-color: var(--accent-color);
        background-color: #fffaf5; /* Laranja bem clarinho */
    }

    .checkbox-label {
        display: flex;
        align-items: flex-start;
        cursor: pointer;
        gap: 12px;
        width: 100%;
    }

    /* Aumentar a área de clique e cor do input */
    .checkbox-label input[type="checkbox"] {
        margin-top: 4px;
        transform: scale(1.3);
        cursor: pointer;
        accent-color: var(--accent-color); /* Deixa o "check" laranja */
    }

    .checkbox-text strong {
        display: block;
        color: var(--primary-color);
        font-size: 15px;
        font-weight: 600;
    }

    .checkbox-text small {
        display: block;
        color: #666;
        font-size: 13px;
        margin-top: 3px;
        line-height: 1.4;
    }

    /* ------- Botões ------- */
    .btn-submit {
        background-color: var(--primary-color);
        border: none;
        transition: 0.3s;
    }
    
    .btn-submit:hover {
        background-color: var(--accent-color);
        transform: translateY(-1px);
    }

    .btn-cancel {
        display: block;
        text-align: center;
        margin-top: 15px;
        color: #777;
        text-decoration: none;
        font-size: 0.9rem;
    }
    .btn-cancel:hover {
        color: var(--danger-color);
        text-decoration: underline;
    }
</style>

<section class="form-section">

    <div class="modern-box" style="max-width: 500px;">

        <div class="form-header">
            <h1><i class="fas fa-user-circle" style="color: var(--accent-color);"></i> {{ 'Editar Usuário' if user else 'Novo Usuário' }}</h1>
            <p>Preencha os dados abaixo para {{ 'atualizar' if user else 'cadastrar' }} a conta.</p>
        </div>

        % if defined('error') and error:
        <div class="error-msg" style="
            background-color: #fff4e5;
            color: #d35400; 
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            border: 1px solid #e67e22;
            font-size: 14px;
            display: flex; align-items: center; gap: 8px;">
            <i class="fas fa-exclamation-triangle"></i> {{error}}
        </div>
        % end

        <form action="{{ '/users/edit/' + str(user.id) if user else '/users/add' }}" method="post" class="styled-form">

            <div class="form-group">
                <label for="email">E-mail de Acesso</label>
                <div style="position: relative;">
                    <input type="email" id="email" name="email" required 
                           value="{{ user.email if user else '' }}" 
                           placeholder="ex: nome@carrent.com"
                           style="padding-left: 40px;">
                    <i class="fas fa-envelope" style="position: absolute; left: 12px; top: 13px; color: #999;"></i>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Senha</label>
                <div style="position: relative;">
                    <input type="password" id="password" name="password" 
                           placeholder="{{ 'Deixe em branco para manter a atual' if user else 'Crie uma senha segura' }}"
                           {{ 'required' if not user else '' }}
                           style="padding-left: 40px;">
                    <i class="fas fa-lock" style="position: absolute; left: 12px; top: 13px; color: #999;"></i>
                </div>
                % if user:
                <small style="color: #888; font-size: 12px; margin-top: 4px; display: block;">* Preencha apenas se quiser alterar a senha.</small>
                % end
            </div>

            <div class="checkbox-group">
                <label class="checkbox-label">
                    <input type="checkbox" name="is_locador" 
                    {{'checked' if user and user.is_locador else ''}}>
                    
                    <div class="checkbox-text">
                        <strong>Perfil de Locador</strong>
                        <small>Habilita o painel administrativo para cadastrar veículos e gerenciar reservas.</small>
                    </div>
                </label>
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i> {{ 'Salvar Alterações' if user else 'Criar Conta' }}
            </button>

            <a href="/users" class="btn-cancel">Cancelar e voltar</a>

        </form>

    </div>

</section>