<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>{{title or "Sistema de Aluguel"}}</title>

    <!-- Materialize CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Ícones Google -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="/static/css/style.css">

</head>
<body>

<nav class="blue darken-2">
    <div class="nav-wrapper container">
        <a href="/" class="brand-logo">EPF</a>
        <ul id="nav-mobile" class="right hide-on-med-and-down">
            <li><a href="/users">Usuários</a></li>
            <li><a href="/activities">Atividades</a></li>
            <li><a href="/rent">Aluguéis</a></li>
        </ul>
    </div>
</nav>

<main class="container" style="margin-top: 40px;">
    {{!base}}
</main>

<!-- Materialize JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    M.AutoInit();
});
</script>

</body>
</html>
