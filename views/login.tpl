<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CarRENT</title>

    <link rel="stylesheet" href="/static/css/style.css" /> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            /* Azul Marinho da Logo (Car) */
            --primary-color: #163b65; 
            /* Variação mais clara para hover */
            --secondary-color: #2c5282; 
            /* Laranja da Logo (RENT) - Usado para destaques */
            --accent-color: #e67e22; 
        }

        body {
            /* Gradiente ajustado para tons de azul marinho e cinza azulado */
            background: linear-gradient(135deg, var(--primary-color), #2c3e50, #bdc3c7);
            background-size: 200% 200%;
            animation: gradientMove 8s ease infinite;
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

       
        .logo-container {
            text-align: center;
            margin-bottom: 25px;
        }

        .logo-img {
            max-width: 180px; /* Tamanho ajustado para o card */
            height: auto;
            display: block;
            margin: 0 auto;
        }

        
        .styled-form input:focus {
            border-color: var(--accent-color); /* Foco laranja */
            box-shadow: 0 0 4px rgba(230, 126, 34, 0.4);
        }

        
        .btn-submit {
            background-color: var(--primary-color);
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background-color: var(--accent-color); /* Hover fica Laranja */
            transform: translateY(-2px);
        }

        
        .password-toggle {
            position: absolute;
            right: 12px;
            top: 40px; 
            cursor: pointer;
            color: #999;
            transition: 0.2s ease;
        }
        .password-toggle:hover {
            color: var(--primary-color);
        }

        /* ------- Link de Registro ------- */
        .register-link {
            color: var(--accent-color); /* Link Laranja */
        }
        .register-link:hover {
            color: var(--primary-color);
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <div class="form-section"> 
        <div class="modern-box" style="max-width: 400px; padding: 40px 30px;">
            
            <div class="logo-container">
                <img src="/static/img/logo-carent.png" alt="CarRENT Logo" class="logo-img">
            </div>

            <div class="form-header">
                <p>Bem-vindo de volta! Faça seu login.</p>
            </div>
            
            % if defined('error'):
                <div class="error-msg" style="
                    background-color: #fff4e5; /* Fundo levemente laranja para erro */
                    color: #d35400; 
                    padding: 12px;
                    border-radius: 6px;
                    margin-bottom: 18px;
                    border: 1px solid #e67e22;
                    font-size: 14px;
                    display: flex; align-items: center; gap: 8px;
                ">
                    <i class="fas fa-exclamation-triangle"></i> {{error}}
                </div>
            % end

            <form action="/login" method="post" class="styled-form">
                <div class="form-group">
                    <label for="email">E-mail</label>
                    <input type="email" id="email" name="email" required placeholder="seu@email.com">
                </div>
                
                <div class="form-group" style="position: relative;">
                    <label for="password">Senha</label>
                    <input type="password" id="password" name="password" required placeholder="Sua senha">
                    <i class="fas fa-eye password-toggle" onclick="togglePassword()"></i>
                </div>

                <button type="submit" class="btn-submit">ACESSAR SISTEMA</button> 
            </form>

            <hr style="margin: 25px 0; border-top: 1px solid #eee;">

            <div style="text-align: center;">
                <p style="color: #777; margin-bottom: 5px;">Não possui cadastro?</p>
                <a href="/users/add" class="register-link" style="font-weight: 700;">Criar uma conta agora</a>
            </div>
        </div>
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