% rebase('base.tpl', title='Cadastro de Usuário')

<div class="container">
    <h4>{{ 'Editar Usuário' if user else 'Novo Usuário' }}</h4>

    <form method="POST" action="{{ action }}">

        <div class="input-field">
            <input id="email" type="email" name="email" value="{{ user.email if user else '' }}" required>
            <label for="email" class="{{'active' if user else ''}}">Email</label>
        </div>

        <div class="input-field">
            <input id="password" type="text" name="password" value="{{ user.password if user else '' }}" required>
            <label for="password" class="{{'active' if user else ''}}">Senha</label>
        </div>

        <div class="input-field">
            <select name="is_locador">
                <option value="0" {{ 'selected' if user and not user.is_locador else '' }}>Não</option>
                <option value="1" {{ 'selected' if user and user.is_locador else '' }}>Sim</option>
            </select>
            <label>É Locador?</label>
        </div>

        <button class="btn green waves-effect waves-light" type="submit">
            Salvar <i class="material-icons right">save</i>
        </button>

        <a href="/users" class="btn-flat">Cancelar</a>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('select');
    M.FormSelect.init(elems);
});
</script>
