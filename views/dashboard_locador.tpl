% rebase('layout.tpl', title='Painel do Locador')

<section class="users-section">

    <!-- CARD DO LOCADOR -->
    <div class="info-card">
        <h2>Olá, {{locador.name}}!</h2>
        <p class="info-line">
            <span><strong>CNPJ:</strong> {{locador.cnpj}}</span>
            <span><strong>Telefone:</strong> {{locador.telephone}}</span>
        </p>

        <a href="/locador/perfil" class="edit-link">
            <i class="fas fa-user-edit"></i> Editar Meus Dados
        </a>
    </div>


    <!-- TÍTULO DA FROTA -->
    <div class="section-header">
        <h1 class="section-title">
            <i class="fas fa-car"></i> Minha Frota
        </h1>

        <a href="/locador/veiculo/add" class="button-primary">
            <i class="fas fa-plus"></i> Adicionar Veículo
        </a>
    </div>


    <!-- TABELA DOS VEÍCULOS -->
    <div class="table-container">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>Placa</th>
                    <th>Modelo / Marca</th>
                    <th>Ano</th>
                    <th>Preço Diária</th>
                    <th>Status</th>
                    <th class="actions-col">Ações</th>
                </tr>
            </thead>

            <tbody>
                % for v in locador.veiculos:
                <tr>
                    <td><strong>{{v.placa}}</strong></td>
                    <td>{{v.modelo}} - {{v.marca}}</td>
                    <td>{{v.ano}}</td>
                    <td>R$ {{v.preco_diaria}}</td>

                    <td>
                        % if v.is_disponivel:
                            <span class="badge badge-green">Disponível</span>
                        % else:
                            <span class="badge badge-orange">Alugado</span>
                        % end
                    </td>

                    <td class="actions">
                        <a href="/locador/veiculo/edit/{{v.id}}" class="btn-action edit">
                            <i class="fas fa-edit"></i> Editar
                        </a>

                        <a href="/locador/veiculo/delete/{{v.id}}"
                           onclick="return confirm('Tem certeza que deseja remover este veículo?')"
                           class="btn-action delete">
                            <i class="fas fa-trash-alt"></i> Excluir
                        </a>
                    </td>
                </tr>
                % end

                % if not locador.veiculos:
                <tr>
                    <td colspan="6" class="empty-message">
                        Nenhum veículo cadastrado ainda.
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>

</section>
