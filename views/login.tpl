<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema</title>
    <link rel="stylesheet" href="/static/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            background-color: #f4f7f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .login-container {
            background-color: white;
            width: 100%;
            max-width: 400px;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
        }

        .login-header h1 {
            color: #333;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
            position: relative; /* Importante para posicionar o olhinho */
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box; /* Garante que o padding não estoure a largura */
        }

        /* Estilo do botão de ver senha (olhinho) */
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 38px; /* Ajuste conforme a altura do label */
            cursor: pointer;
            color: #777;
        }

        .btn-submit {
            background-color: #3498db;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            width: 100%;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s;
        }

        .btn-submit:hover {
            background-color: #2980b9;
        }

        .error-msg {
            background-color: #fee;
            color: #c0392b;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            border: 1px solid #f5c6cb;
        }

        .register-link {
            margin-top: 20px;
            display: block;
            color: #3498db;
            text-decoration: none;
        }
        
        .register-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <div class="login-header">
            <h1><i class="fas fa-car-side"></i> Login</h1>
        </div>
        
        % if defined('error'):
            <div class="error-msg">
                <i class="fas fa-exclamation-circle"></i> {{error}}
            </div>
        % end

        <form action="/login" method="post">
            <div class="form-group">
                <label for="email">E-mail</label>
                <input type="email" id="email" name="email" required placeholder="seu@email.com">
            </div>
            
            <div class="form-group">
                <label for="password">Senha</label>
                <input type="password" id="password" name="password" required placeholder="Sua senha">
                <i class="fas fa-eye password-toggle" onclick="togglePassword()"></i>
            </div>
            
            <button type="submit" class="btn-submit">Entrar</button>
        </form>

        <hr style="margin: 20px 0; border: 0; border-top: 1px solid #eee;">
        
        <p>Ainda não tem conta?</p>
        <a href="/users/add" class="register-link">Criar nova conta</a>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.querySelector('.password-toggle');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>