<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema</title>

    <link rel="stylesheet" href="/static/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* ------- Layout geral ------- */
        body {
            background: linear-gradient(135deg, #3498db, #6dd5fa, #ffffff);
            background-size: 200% 200%;
            animation: gradientMove 6s ease infinite;
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* ------- Card de Login ------- */
        .login-container {
            background: #fff;
            width: 100%;
            max-width: 430px;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            text-align: center;
            animation: fadeIn 0.6s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .login-header h1 {
            margin: 0 0 20px;
            font-size: 28px;
            color: #333;
        }

        .login-header i {
            color: #3498db;
            margin-right: 8px;
        }

        /* ------- Inputs ------- */
        .form-group {
            margin-bottom: 18px;
            text-align: left;
            position: relative;
        }

        .form-group label {
            font-weight: 600;
            color: #555;
            margin-bottom: 5px;
            display: block;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 15px;
            transition: 0.25s ease;
        }

        .form-group input:focus {
            border-color: #3498db;
            box-shadow: 0 0 6px rgba(52,152,219,0.35);
            outline: none;
        }

        /* ------- Mostrar/ocultar senha ------- */
        .password-toggle {
            position: absolute;
            right: 12px;
            top: 40px;
            cursor: pointer;
            color: #777;
            transition: 0.2s ease;
        }

        .password-toggle:hover {
            color: #3498db;
        }

        /* ------- Botão ------- */
        .btn-submit {
            background: #3498db;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            width: 100%;
            font-size: 17px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.25s ease;
            margin-top: 5px;
        }

        .btn-submit:hover {
            background: #217dbb;
            transform: translateY(-2px);
        }

        /* ------- Erro ------- */
        .error-msg {
            background-color: #ffe5e5;
            color: #c0392b;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 18px;
            border: 1px solid #f5c6cb;
            font-size: 14px;
            text-align: left;
        }

        .error-msg i {
            margin-right: 6px;
        }

        /* ------- Link de registro ------- */
        .register-link {
            display: block;
            margin-top: 18px;
            color: #3498db;
            font-weight: bold;
            text-decoration: none;
            transition: 0.2s ease;
        }

        .register-link:hover {
            text-decoration: underline;
        }

        hr {
            border: none;
            border-top: 1px solid #eee;
            margin: 25px 0;
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

        <hr>

        <p>Ainda não tem conta?</p>
        <a href="/users/add" class="register-link">Criar nova conta</a>
    </div>

    <script>
        function togglePassword() {
            const password = document.getElementById("password");
            const icon = document.querySelector(".password-toggle");

            if (password.type === "password") {
                password.type = "text";
                icon.classList.replace("fa-eye", "fa-eye-slash");
            } else {
                password.type = "password";
                icon.classList.replace("fa-eye-slash", "fa-eye");
            }
        }
    </script>

</body>
</html>
