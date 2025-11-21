% rebase('layout', title='Formulário Usuário')

<section class="form-section">
    <h1>{{'Editar Usuário' if user else 'Adicionar Usuário'}}</h1>
    
    <form action="{{action}}" method="post" class="form-container">
        <div class="form-group">
            <label for="name">Nome:</label>
            <input type="text" id="name" name="name" required 
                   value="{{user.name if user else ''}}">
        </div>
        
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required 
                   value="{{user.email if user else ''}}">
        </div>
        
        <div class="form-group">
            <label for="password">Senha:</label>
            <input type="text" id="password" name="password" required 
                   value="{{user.password if user else ''}}">
        </div>

        <div class="form-group">
            <label for="telephone">Telefone:</label>
            <input type="text" id="telephone" name="telephone" required 
                   value="{{user.telephone if user else ''}}">
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn-submit">Salvar</button>
            <a href="/users" class="btn-cancel">Voltar</a>
        </div>
    </form>
</section>