% rebase('layout.tpl', title='Painel do Locador')

<section class="users-section">
    <div style="background: white; padding: 20px; border-radius: 8px; margin-bottom: 30px; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
        <h2>Olá, {{locador.name}}!</h2>
        <p><strong>CNPJ:</strong> {{locador.cnpj}} | <strong>Tel:</strong> {{locador.telephone}}</p>
        <a href="/locador/perfil" style="color: #3498db; text-decoration: none;">
            <i class="fas fa-edit"></i> Editar Meus Dados
        </a>
    </div>

    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-car"></i> Minha Frota</h1>
        <a href="/locador/veiculo/add" class="btn btn-primary" style="background-color: #27ae60; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">
            <i class="fas fa-plus"></i> Adicionar Veículo
        </a>
    </div>

    <div class="table-container">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>Placa</th>
                    <th>Modelo/Marca</th>
                    <th>Ano</th>
                    <th>Preço Diária</th>
                    <th>Status</th>
                    <th>Ações</th>
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
                            <span style="color: green; background: #e8f5e9; padding: 4px 8px; border-radius: 4px;">Disponível</span>
                        % else:
                            <span style="color: orange; background: #fff3e0; padding: 4px 8px; border-radius: 4px;">Alugado</span>
                        % end
                    </td>
                    <td class="actions">
                        <a href="/locador/veiculo/edit/{{v.id}}" class="btn btn-sm" style="color: #f39c12; margin-right: 10px;">
                            <i class="fas fa-edit"></i> Editar
                        </a>
                        <a href="/locador/veiculo/delete/{{v.id}}" 
                           onclick="return confirm('Tem certeza que deseja remover este veículo?')"
                           class="btn btn-sm btn-danger" style="color: #c0392b;">
                            <i class="fas fa-trash-alt"></i> Excluir
                        </a>
                    </td>
                </tr>
                % end
                
                % if not locador.veiculos:
                <tr>
                    <td colspan="6" style="text-align: center; padding: 20px; color: #777;">
                        Nenhum veículo cadastrado ainda.
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>
</section>