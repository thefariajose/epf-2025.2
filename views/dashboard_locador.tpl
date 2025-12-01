% rebase('layout.tpl', title='Painel do Locador')

<style>
    /* -----------------------------------------
       CSS ESSENCIAL (Para o Painel Locador)
    ----------------------------------------- */
    
    /* Card de Informações do Locador */
    .locador-card {
        background: white;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 30px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08); /* Sombra mais destacada */
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-left: 5px solid var(--accent-color); /* Linha Laranja de destaque */
    }

    .locador-info h2 {
        margin-top: 0;
        color: var(--primary-color);
        font-size: 1.75rem;
    }

    /* Botão Primário (Editar) - Padronizado */
    .btn-edit-profile {
        background-color: var(--secondary-color); /* Azul mais suave para editar */
        color: white;
        text-decoration: none;
        padding: 10px 15px;
        border-radius: 6px;
        transition: background-color 0.2s;
        font-weight: 500;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }
    .btn-edit-profile:hover {
        background-color: var(--primary-color);
    }

    /* Título da Seção (Padrão) */
    .section-title-highlight {
        color: var(--primary-color);
        border-bottom: 2px solid var(--accent-color); /* Sublinhado Laranja */
        padding-bottom: 10px;
        margin-bottom: 20px;
        font-size: 1.5rem;
    }

    /* Mensagem Vazia */
    .empty-message-locador {
        background: #fff; 
        padding: 25px; 
        border-radius: 8px; 
        text-align: center; 
        color: #777; 
        border: 2px dashed #e0e0e0;
    }
    
    /* Botões de Ação na Tabela (Aceitar/Rejeitar) */
    .btn-accept {
        background-color: var(--success-color, #27ae60);
        color: white;
        margin-right: 5px;
        text-decoration: none;
        padding: 6px 12px;
        border-radius: 4px;
        font-size: 0.9rem;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        transition: 0.2s;
    }
    .btn-accept:hover { background-color: #2ecc71; }

    .btn-reject {
        background-color: #c0392b;
        color: white;
        text-decoration: none;
        padding: 6px 12px;
        border-radius: 4px;
        font-size: 0.9rem;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        transition: 0.2s;
    }
    .btn-reject:hover { background-color: #e74c3c; }

    /* Estilos de Status (Frota) */
    .status-available, .status-unavailable {
        display: inline-block;
        padding: 6px 10px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 0.85rem;
    }

    .status-available {
        color: var(--success-color, #27ae60);
        background: #e8f5e9; 
    }
    .status-unavailable {
        color: var(--accent-color); /* Laranja */
        background: #fff3e0;
    }

    /* Botão Adicionar Veículo (Laranja de destaque) */
    .btn-add-vehicle {
        background-color: var(--accent-color);
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 6px;
        transition: 0.2s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-weight: 600;
    }
    .btn-add-vehicle:hover {
        background-color: #d35400; /* Laranja mais escuro */
    }

    /* Ações da Frota */
    .fleet-actions a {
        color: var(--secondary-color);
        text-decoration: none;
        margin: 0 5px;
        transition: color 0.2s;
    }
    .fleet-actions a:hover {
        color: var(--primary-color);
    }
    .fleet-actions .delete-btn-text {
        color: #c0392b;
    }
    .fleet-actions .delete-btn-text:hover {
        color: #e74c3c;
    }
    
    /* Tabela Genérica (reutilizando a data-table, que precisa estar no layout.tpl ou style.css) */
    .table-responsive { overflow-x: auto; background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
    .data-table { width: 100%; border-collapse: collapse; margin: 0; }
    .data-table th, .data-table td { padding: 14px 20px; text-align: left; border-bottom: 1px solid #f0f0f0; vertical-align: middle; }
    .data-table th { background-color: var(--primary-color); color: white; font-weight: 600; text-transform: uppercase; font-size: 0.85rem; }
    .data-table tbody tr:hover { background-color: #f9f9f9; }

</style>

<section class="locador-dashboard">
    
    <div class="locador-card">
        <div class="locador-info">
            <h2>Olá, {{locador.name}}! 👋</h2>
            <p style="margin-bottom: 0;">
                <small><strong>CNPJ:</strong> {{locador.cnpj}} | <strong>Telefone:</strong> {{locador.telephone}}</small>
            </p>
        </div>
        <div>
            <a href="/locador/perfil" class="btn-edit-profile">
                <i class="fas fa-edit"></i> Editar Meus Dados
            </a>
        </div>
    </div>

    <div style="margin-bottom: 50px;">
        <h2 class="section-title-highlight">
            <i class="fas fa-envelope-open-text"></i> Solicitações de Aluguel Pendentes
        </h2>
        
        % if solicitacoes:
        <div class="table-responsive">
            <table class="data-table">
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
                        <td class="total-value">{{sol.valor_total}}</td>
                        <td>
                            <a href="/locador/aluguel/aceitar/{{sol.id}}" 
                               onclick="return confirm('Aceitar aluguel? O carro ficará indisponível.')"
                               class="btn-accept">
                                <i class="fas fa-check"></i> Aceitar
                            </a>
                            <a href="/locador/aluguel/rejeitar/{{sol.id}}" 
                               onclick="return confirm('Rejeitar solicitação?')"
                               class="btn-reject">
                                <i class="fas fa-times"></i> Rejeitar
                            </a>
                        </td>
                    </tr>
                    % end
                </tbody>
            </table>
        </div>
        % else:
        <div class="empty-message-locador">
            <i class="fas fa-inbox"></i> Nenhuma solicitação pendente no momento.
        </div>
        % end
    </div>

    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-car" style="color: var(--primary-color);"></i> Minha Frota</h1>
        <a href="/locador/veiculo/add" class="btn-add-vehicle">
            <i class="fas fa-plus-circle"></i> Adicionar Veículo
        </a>
    </div>

    <div class="table-responsive">
        <table class="data-table">
            <thead>
                <tr>
                    <th>Placa</th>
                    <th>Veículo</th>
                    <th>Ano</th>
                    <th>Preço Diária</th>
                    <th>Status</th>
                    <th class="text-center">Ações</th>
                </tr>
            </thead>
            <tbody>
                % for v in locador.veiculos:
                <tr>
                    <td><strong>{{v.placa}}</strong></td>
                    <td>{{v.modelo}} - <small class="text-secondary">{{v.marca}}</small></td>
                    <td>{{v.ano}}</td>
                    <td class="total-value">R$ {{v.preco_diaria}}</td>
                    <td>
                        % if v.is_disponivel:
                            <span class="status-available">Disponível</span>
                        % else:
                            <span class="status-unavailable">Indisponível</span>
                        % end
                    </td>
                    <td class="fleet-actions text-center">
                        <a href="/locador/veiculo/edit/{{v.id}}" title="Editar Veículo">
                            <i class="fas fa-edit"></i> Editar
                        </a>
                        <a href="/locador/veiculo/delete/{{v.id}}" 
                           onclick="return confirm('Tem certeza que deseja remover este veículo?')"
                           class="delete-btn-text" title="Excluir Veículo">
                            <i class="fas fa-trash-alt"></i> Excluir
                        </a>
                    </td>
                </tr>
                % end
                
                % if not locador.veiculos:
                <tr>
                    <td colspan="6" class="empty-message">
                        <i class="fas fa-car-side"></i> Nenhum veículo cadastrado ainda. Use o botão "Adicionar Veículo" acima.
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>
</section>