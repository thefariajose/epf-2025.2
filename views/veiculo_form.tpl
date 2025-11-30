% rebase('layout.tpl', title='Novo Veículo')

<div style="display: flex; justify-content: center; padding: 20px;">
    <div class="form-container-box" style="max-width: 600px;">
        <div class="form-header">
            <h1><i class="fas fa-car"></i> Novo Veículo</h1>
            <p>Adicione um carro à sua frota</p>
        </div>

        <form action="/locador/veiculo/add" method="post">
            
            <div style="display: flex; gap: 15px;">
                <div class="form-group" style="flex: 1;">
                    <label>Placa</label>
                    <input type="text" name="placa" required placeholder="ABC-1234">
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Marca</label>
                    <input type="text" name="marca" required placeholder="Ex: Fiat">
                </div>
            </div>

            <div class="form-group">
                <label>Modelo</label>
                <input type="text" name="modelo" required placeholder="Ex: Uno Mille">
            </div>

            <div style="display: flex; gap: 15px;">
                <div class="form-group" style="flex: 1;">
                    <label>Ano</label>
                    <input type="number" name="ano" required placeholder="2020">
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Quilometragem</label>
                    <input type="number" name="quilometragem" required placeholder="0">
                </div>
            </div>

            <div class="form-group">
                <label>Preço da Diária (R$)</label>
                <input type="number" step="0.01" name="preco_diaria" required placeholder="100.00">
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-plus-circle"></i> Cadastrar Veículo
            </button>
            
            <div style="text-align: center; margin-top: 15px;">
                <a href="/dashboard-locador" style="color: #777; text-decoration: none;">Cancelar</a>
            </div>
        </form>
    </div>
</div>