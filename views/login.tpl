% rebase('layout.tpl', title='Login')

<style>
    .login-container {
        max-width: 400px;
        margin: 50px auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        text-align: center;
    }
    .error-msg {
        color: red;
        margin-bottom: 10px;
    }
    .btn-register {
        display: inline-block;
        margin-top: 15px;
        color: #3498db;
        text-decoration: none;
    }
</style>

<div class="login-container">
    <h1>Acessar Sistema</h1>
    
    % if defined('error'):
        <p class="error-msg">{{error}}</p>
    % end

    <form action="/login" method="post">
        <div class="form-group">
            <label for="email">E-mail:</label><br>
            <input type="email" name="email" required style="width: 90%; padding: 8px;">
        </div>
        <br>
        <div class="form-group">
            <label for="password">Senha:</label><br>
            <input type="password" name="password" required style="width: 90%; padding: 8px;">
        </div>
        <br>
        <button type="submit" class="btn-submit" style="width: 100%;">Entrar</button>
    </form>

    <hr>
    
    <p>Ainda não tem conta?</p>
    <a href="/users/add" class="btn-register">Cadastrar novo Usuário</a>
</div>