% rebase('layout.tpl', title='Meus Aluguéis')

<style>
    /* -----------------------------------------
       ESTILOS DA TABELA E BADGES (Para funcionar imediatamente)
    ----------------------------------------- */
    
    /* Container para permitir rolagem em telas pequenas */
    .table-responsive {
        overflow-x: auto; 
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    
    /* Tabela Principal */
    .data-table {
        width: 100%;
        border-collapse: collapse;
        margin: 0;
    }

    .data-table th, .data-table td {
        padding: 14px 20px;
        text-align: left;
        border-bottom: 1px solid #f0f0f0;
        vertical-align: middle;
    }

    .data-table th {
        background-color: var(--primary-color); 
        color: white;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.85rem;
    }

    .data-table tbody tr:hover {
        background-color: #f9f9f9;
    }

    /* Estilos de Status Badge */
    .status-badge {
        display: inline-block;
        padding: 6px 10px;
        border-radius: 6px;
        font-size: 0.85rem;
        font-weight: 700;
        text-transform: uppercase;
        white-space: nowrap; 
    }

    /* 🟠 Em Negociação (Laranja / Accent) */
    .status-negociacao {
        background: #fef7ec; 
        color: var(--accent-color);
    }
    /* 🟢 Alugado/Aceito */
    .status-aceito {
        background: #e9f8ed; 
        color: var(--success-color, #27ae60);
    }
    /* 🔴 Rejeitado */
    .status-rejeitado {
        background: #fcebeb; 
        color: #c0392b;
    }
    /* ⚫ Concluído */
    .status-concluido {
        background: #e9ecef; 
        color: #6c757d;
    }
    
    /* Estilo para a Coluna do Valor Total (Azul Marinho) */
    .total-value {
        font-weight: 700;
        color: var(--primary-color);
    }

    /* Estilo para o botão "Voltar para Vitrine" no cabeçalho */
    .back-to-vitrine {
        background-color: #34495e; 
        color: white;
        padding: 10px 15px;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 600;
        transition: 0.2s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .back-to-vitrine:hover {
        background-color: #49637f;
    }

    /* Botão de Devolução */
    .btn-devolver {
        background-color: var(--primary-color);
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 4px;
        cursor: pointer;
        font-weight: 500;
        text-decoration: none;
        transition: background-color 0.2s;
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .btn-devolver:hover {
        background-color: var(--secondary-color);
    }

    .text-secondary {
        color: #777;
        font-size: 0.9em;
    }

    .empty-message {
        text-align: center; 
        padding: 30px; 
        color: #777; 
        font-style: italic;
        background: #fff;
        border-radius: 10px;
        grid-column: 1 / -1; /* Para ocupar toda a largura em grids */
    }

</style>

<section class="admin-list-section">
    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-history" style="color: var(--accent-color);"></i> Meus Aluguéis</h1>
        
        <a href="/cliente/vitrine" class="back-to-vitrine">
            <i class="fas fa-car-side"></i> Voltar para Vitrine
        </a>
    </div>

    <div class="table-responsive">
        <table class="data-table">
            <thead>
                <tr>
                    <th>Veículo</th>
                    <th>Período</th>
                    <th>Valor Total</th>
                    <th>Status</th>
                    <th class="text-center">Ações</th>
                </tr>
            </thead>
            <tbody>
                % for item in dados:
                % locacao = item['locacao']
                % carro = item['carro']
                <tr>
                    <td>
                        <strong>{{carro.modelo}}</strong><br>
                        <small class="text-secondary">{{carro.marca}} ({{carro.placa}})</small>
                    </td>
                    <td>
                        <small>De:</small> **{{locacao.data_inicio}}**<br>
                        <small>Até:</small> **{{locacao.data_fim}}**
                    </td>
                    <td class="total-value">R$ {{locacao.valor_total}}</td>
                    <td>
                        % if locacao.status == 'em_negociacao':
                            <span class="status-badge status-negociacao">Em Negociação</span>
                        % elif locacao.status == 'aceito':
                            <span class="status-badge status-aceito">Alugado</span>
                        % elif locacao.status == 'rejeitado':
                            <span class="status-badge status-rejeitado">Rejeitado</span>
                        % elif locacao.status == 'concluido':
                            <span class="status-badge status-concluido">Concluído</span>
                        % end
                    </td>
                    <td class="text-center">
                        % if locacao.status == 'aceito':
                        <form action="/cliente/aluguel/concluir/{{locacao.id}}" method="post" onsubmit="return confirm('Confirmar devolução do veículo?')">
                            <button type="submit" class="btn-devolver">
                                <i class="fas fa-key"></i> Devolver
                            </button>
                        </form>
                        % else:
                        <span class="text-secondary">-</span>
                        % end
                    </td>
                </tr>
                % end

                % if not dados:
                <tr>
                    <td colspan="5" class="empty-message">
                        <i class="fas fa-info-circle"></i> Você ainda não realizou nenhum aluguel.
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>
</section>