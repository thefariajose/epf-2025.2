% rebase('layout.tpl', title='Painel do Locador')

<section class="users-section">
    <div style="background: white; padding: 20px; border-radius: 8px; margin-bottom: 30px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); display: flex; justify-content: space-between; align-items: center;">
        <div>
            <h2 style="margin-top: 0;">Olá, {{locador.name}}!</h2>
            <p style="margin-bottom: 0;"><strong>CNPJ:</strong> {{locador.cnpj}} | <strong>Tel:</strong> {{locador.telephone}}</p>
        </div>
        <div>
            <a href="/locador/perfil" class="btn btn-sm" style="background: #3498db; color: white; text-decoration: none;">
                <i class="fas fa-edit"></i> Editar Meus Dados
            </a>
        </div>
    </div>

    <div style="margin-bottom: 50px;">
        <h2 style="color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; margin-bottom: 20px;">
            <i class="fas fa-envelope-open-text"></i> Solicitações de Aluguel
        </h2>
        
        % if solicitacoes:
        <div class="table-container">
            <table class="styled-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Veículo (ID)</th>
                        <th>Data Início</th>
                        <th>Data Fim</th>
                        <th>Valor Total (R$)</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    % for sol in solicitacoes:
                    <tr>
                        <td>#{{sol.id}}</td>
                        <td>{{sol.veiculo_id}}</td>
                        <td>{{sol.data_inicio}}</td>
                        <td>{{sol.data_fim}}</td>
                        <td style="font-weight: bold; color: green;">{{sol.valor_total}}</td>
                        <td>
                            <a href="/locador/aluguel/aceitar/{{sol.id}}" 
                               onclick="return confirm('Aceitar aluguel? O carro ficará indisponível.')"
                               class="btn btn-sm" style="background-color: #27ae60; color: white; margin-right: 5px; text-decoration: none; padding: 5px 10px; border-radius: 4px;">
                                <i class="fas fa-check"></i> Aceitar
                            </a>
                            <a href="/locador/aluguel/rejeitar/{{sol.id}}" 
                               onclick="return confirm('Rejeitar solicitação?')"
                               class="btn btn-sm" style="background-color: #c0392b; color: white; text-decoration: none; padding: 5px 10px; border-radius: 4px;">
                                <i class="fas fa-times"></i> Rejeitar
                            </a>
                        </td>
                    </tr>
                    % end
                </tbody>
            </table>
        </div>
        % else:
        <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; text-align: center; color: #777; border: 1px dashed #ccc;">
            <i class="fas fa-inbox"></i> Nenhuma solicitação pendente no momento.
        </div>
        % end
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
                            <span style="color: orange; background: #fff3e0; padding: 4px 8px; border-radius: 4px;">Indisponível</span>
                        % end
                    </td>
                    <td class="actions">
                        <a href="/locador/veiculo/edit/{{v.id}}" class="btn btn-sm" style="color: #f39c12; margin-right: 10px; text-decoration: none;">
                            <i class="fas fa-edit"></i> Editar
                        </a>
                        <a href="/locador/veiculo/delete/{{v.id}}" 
                           onclick="return confirm('Tem certeza que deseja remover este veículo?')"
                           class="btn btn-sm btn-danger" style="color: #c0392b; text-decoration: none;">
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