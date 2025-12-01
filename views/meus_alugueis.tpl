% rebase('layout.tpl', title='Meus Aluguéis')

<section class="users-section">
    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-history"></i> Meus Aluguéis</h1>
        <a href="/cliente/vitrine" class="btn btn-primary">Voltar para Vitrine</a>
    </div>

    <div class="table-container">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>Veículo</th>
                    <th>Período</th>
                    <th>Valor Total</th>
                    <th>Status</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                % for item in dados:
                % locacao = item['locacao']
                % carro = item['carro']
                <tr>
                    <td>
                        <strong>{{carro.modelo}}</strong><br>
                        <small>{{carro.marca}} ({{carro.placa}})</small>
                    </td>
                    <td>
                        <small>De:</small> {{locacao.data_inicio}}<br>
                        <small>Até:</small> {{locacao.data_fim}}
                    </td>
                    <td style="font-weight: bold;">R$ {{locacao.valor_total}}</td>
                    <td>
                        % if locacao.status == 'em_negociacao':
                            <span style="color: orange; font-weight: bold; background: #fff3e0; padding: 4px 8px; border-radius: 4px;">Em Negociação</span>
                        % elif locacao.status == 'aceito':
                            <span style="color: green; font-weight: bold; background: #e8f5e9; padding: 4px 8px; border-radius: 4px;">Alugado</span>
                        % elif locacao.status == 'rejeitado':
                            <span style="color: #c0392b; font-weight: bold; background: #fce4ec; padding: 4px 8px; border-radius: 4px;">Rejeitado</span>
                        % elif locacao.status == 'concluido':
                            <span style="color: gray; font-weight: bold; background: #eee; padding: 4px 8px; border-radius: 4px;">Concluído</span>
                        % end
                    </td>
                    <td>
                        % if locacao.status == 'aceito':
                        <form action="/cliente/aluguel/concluir/{{locacao.id}}" method="post" onsubmit="return confirm('Confirmar devolução do veículo?')">
                            <button type="submit" class="btn btn-sm" style="background: #34495e; color: white; border:none; padding: 5px 10px; border-radius: 4px; cursor: pointer;">
                                <i class="fas fa-key"></i> Devolver
                            </button>
                        </form>
                        % else:
                        <span style="color: #ccc;">-</span>
                        % end
                    </td>
                </tr>
                % end

                % if not dados:
                <tr>
                    <td colspan="5" style="text-align:center; padding: 20px; color: #777;">
                        Você ainda não realizou nenhum aluguel.
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>
</section>