% rebase('layout.tpl', title='Usuário')

<section class="form-section">

    <div class="form-container-box modern-box">

        <div class="form-header">
            <h1><i class="fas fa-user"></i> {{ 'Editar Usuário' if user else 'Novo Usuário' }}</h1>
            <p>Gerencie contas do sistema.</p>
        </div>

        <form action="{{ '/users/edit/' + str(user.id) if user else '/users/add' }}" method="post">

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required
                       value="{{ user.email if user else '' }}"
                       placeholder="email@exemplo.com">
            </div>

            <div class="form-group">
                <label>Senha</label>
                <input type="password" name="password"
                       placeholder="{{ 'Deixe em branco para não alterar' if user else 'Digite a senha' }}">
            </div>

            <div class="form-group">
                <label>Tipo de Conta</label>

                <select name="is_locador" class="styled-select">
                    <option value="0" {{ 'selected' if user and not user.is_locador else '' }}>Cliente</option>
                    <option value="1" {{ 'selected' if user and user.is_locador else '' }}>Locador</option>
                </select>
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i> Salvar
            </button>

        </form>

    </div>

</section>
