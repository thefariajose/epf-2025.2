%rebase('layout', title='Usuários')

<section class="users-section">
    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-users"></i> Usuários Cadastrados</h1>
        <a href="/users/add" class="btn btn-primary">
            <i class="fas fa-plus"></i> Novo Usuário
        </a>
    </div>

    <div class="table-container">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Tipo de Conta</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                % for u in users:
                <tr>
                    <td>{{u.id}}</td>
                    <td>{{u.email}}</td>

                    <td>
                        % if u.is_locador:
                            <span style="color: green; font-weight: bold; background: #e8f5e9; padding: 4px 8px; border-radius: 4px;">Locador</span>
                        % else:
                            <span style="color: #2c3e50; background: #eceff1; padding: 4px 8px; border-radius: 4px;">Cliente</span>
                        % end
                    </td>

                    <td class="actions">
                        <a href="/users/edit/{{u.id}}" class="btn btn-sm btn-edit">
                            <i class="fas fa-edit"></i>
                        </a>
                        
                        <form action="/users/delete/{{u.id}}" method="post" 
                              onsubmit="return confirm('Tem certeza?')" style="display:inline;">
                            <button type="submit" class="btn btn-sm btn-danger">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </form>
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>
</section>