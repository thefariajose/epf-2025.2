% rebase('layout.tpl', title='Solicitar Aluguel')

<div style="display: flex; justify-content: center; padding: 20px;">
    <div class="form-container-box" style="max-width: 600px;">
        <div class="form-header">
            <h1><i class="fas fa-calendar-check"></i> Alugar Veículo</h1>
            <p>Você está solicitando: <strong>{{veiculo.modelo}}</strong> ({{veiculo.marca}})</p>
            <p style="color: green; font-weight: bold;">Diária base: R$ {{veiculo.preco_diaria}}</p>
        </div>

        <form action="/cliente/alugar/{{veiculo.id}}" method="post">
            
            <div style="display: flex; gap: 15px;">
                <div class="form-group" style="flex: 1;">
                    <label>Data de Início</label>
                    <input type="date" name="data_inicio" required id="inicio">
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Data de Fim</label>
                    <input type="date" name="data_fim" required id="fim">
                </div>
            </div>

            <div style="background: #e8f4fd; padding: 15px; border-radius: 4px; color: #0c5460; font-size: 0.9em; margin-bottom: 20px; border-left: 4px solid #3498db;">
                <i class="fas fa-info-circle"></i> <strong>Atenção:</strong> O valor total será calculado automaticamente incluindo o período selecionado + taxa de serviço de 30%. O pedido ficará "Em Negociação" até o locador aceitar.
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-paper-plane"></i> Enviar Solicitação
            </button>
            
            <div style="text-align: center; margin-top: 15px;">
                <a href="/cliente/vitrine" style="color: #777; text-decoration: none;">Cancelar</a>
            </div>
        </form>
    </div>
</div>