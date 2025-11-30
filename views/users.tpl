% rebase('base.tpl', title='Usuários')

<div class="container">
    <div class="row">
        <div class="col s12">
            <h4 class="center-align">Lista de Usuários</h4>

            <div class="right-align">
                <a href="/users/add" class="btn waves-effect waves-light">
                    <i class="material-icons left">add</i>Novo Usuário
                </a>
            </div>

            <table class="striped highlight responsive-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Email</th>
                        <th>Senha</th>
                        <th>Locador?</th>
                        <th>Ações</th>
                    </tr>
                </thead>

                <tbody>
                    % for user in users:
                    <tr>
                        <td>{{ user.id }}</td>
                        <td>{{ user.email }}</td>
                        <td>{{ user.password }}</td>
                        <td>{{ 'Sim' if user.is_locador else 'Não' }}</td>

                        <td>
                            <a href="/users/edit/{{ user.id }}" class="btn-small blue lighten-1">
                                <i class="material-icons">edit</i>
                            </a>

                            <form action="/users/delete/{{ user.id }}" method="POST" style="display:inline;">
                                <button class="btn-small red" onclick="return confirm('Excluir usuário?')">
                                    <i class="material-icons">delete</i>
                                </button>
                            </form>
                        </td>
                    </tr>
                    % end
                </tbody>
            </table>
        </div>
    </div>
</div>
