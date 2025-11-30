<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar Conta - Sistema</title>
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

        .form-container-box {
            background-color: white;
            width: 100%;
            max-width: 400px;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .form-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .form-header h1 {
            color: #333;
            font-size: 24px;
            margin: 0;
        }

        .form-header p {
            color: #777;
            font-size: 14px;
            margin-top: 5px;
        }

        .form-group {
            margin-bottom: 15px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }

        .form-group input[type="email"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        /* Estilo do Checkbox customizado */
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
        }

        .checkbox-text strong {
            display: block;
            color: #2c3e50;
        }

        .checkbox-text small {
            display: block;
            color: #7f8c8d;
            font-size: 12px;
            margin-top: 2px;
        }

        .btn-submit {
            background-color: #27ae60; /* Verde para diferenciar do Login azul */
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            width: 100%;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s;
        }

        .btn-submit:hover {
            background-color: #219150;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .login-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 38px;
            cursor: pointer;
            color: #777;
        }
    </style>
</head>
<body>

    <div class="form-container-box">
        <div class="form-header">
            <h1>Criar Conta</h1>
            <p>Preencha os dados para começar</p>
        </div>
        
        <form action="{{action}}" method="post">
            
            <div class="form-group">
                <label for="email">E-mail</label>
                <input type="email" id="email" name="email" required 
                       value="{{user.email if user else ''}}" placeholder="exemplo@email.com">
            </div>
            
            <div class="form-group">
                <label for="password">Senha</label>
                <input type="password" id="password" name="password" required 
                       value="{{user.password if user else ''}}" placeholder="Crie uma senha segura">
                <i class="fas fa-eye password-toggle" onclick="togglePassword()"></i>
            </div>

            <div class="checkbox-group">
                <label class="checkbox-label">
                    <input type="checkbox" name="is_locador" 
                    {{'checked' if user and user.is_locador else ''}}>
                    
                    <div class="checkbox-text">
                        <strong>Sou Locador</strong>
                        <small>Marque se você deseja alugar seus veículos na plataforma.</small>
                    </div>
                </label>
            </div>
            
            <button type="submit" class="btn-submit">Confirmar Cadastro</button>
        </form>

        <div class="login-link">
            <p>Já possui uma conta?</p>
            <a href="/login"><i class="fas fa-arrow-left"></i> Voltar para o Login</a>
        </div>
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