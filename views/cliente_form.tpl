% rebase('layout.tpl', title='Perfil do Cliente')

<div style="display: flex; justify-content: center; padding: 20px;">
    <div class="form-container-box" style="max-width: 600px;">
        <div class="form-header">
            <h1><i class="fas fa-user"></i> Dados do Cliente</h1>
            <p>Complete seu cadastro para alugar veículos.</p>
        </div>

        <form action="/cliente/perfil" method="post">
            
            <div class="form-group">
                <label>Nome Completo</label>
                <input type="text" name="name" required 
                       value="{{cliente.name if cliente else ''}}">
            </div>

            <div class="form-group">
                <label>CPF</label>
                <input type="text" name="cpf" required 
                       value="{{cliente.cpf if cliente else ''}}" placeholder="000.000.000-00">
            </div>

            <div class="form-group">
                <label>Telefone</label>
                <input type="text" name="telephone" required 
                       value="{{cliente.telephone if cliente else ''}}">
            </div>

            <div class="form-group">
                <label>Endereço Completo</label>
                <input type="text" name="endereco" required 
                       value="{{cliente.endereco if cliente else ''}}">
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i> Salvar e Ver Carros
            </button>
        </form>
    </div>
</div>