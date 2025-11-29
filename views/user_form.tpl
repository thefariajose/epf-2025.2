% rebase('layout', title='Cadastro de Usuário')

<section class="form-section">
    <h1>{{'Editar Usuário' if user else 'Criar Conta'}}</h1>
    
    <form action="{{action}}" method="post" class="form-container">
        <div class="form-group">
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email" required 
                   value="{{user.email if user else ''}}">
        </div>

        <div class="form-group">
            <label for="password">Senha:</label>
            <input type="password" id="password" name="password" required 
                   value="{{user.password if user else ''}}">
        </div>

        <div class="form-group" style="margin-top: 20px; padding: 15px; background-color: #f0f4f8; border-radius: 8px; border: 1px solid #ddd;">
            <label style="display: flex; align-items: center; gap: 10px; cursor: pointer;">
                <input type="checkbox" name="is_locador" style="width: 20px; height: 20px;"
                {{'checked' if user and user.is_locador else ''}}>
                
                <span>
                    <strong>Sou Locador</strong><br>
                    <small style="color: #555;">Marque se você deseja disponibilizar veículos.</small>
                </span>
            </label>
        </div>

        <div class="form-actions" style="margin-top: 20px;">
            <button type="submit" class="btn-submit">Criar Conta</button>
            <a href="/login" class="btn-cancel" style="margin-left: 10px;">Voltar</a>
        </div>
    </form>
</section>