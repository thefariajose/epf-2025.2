% rebase('layout.tpl', title='Veículos Disponíveis')

<section class="users-section">
    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-car-side"></i> Veículos Disponíveis</h1>
        <div style="text-align: right;">
            <span>Olá, {{cliente.name}}!</span> | 
            <a href="/cliente/perfil">Editar Perfil</a>
        </div>
    </div>

    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; margin-top: 20px;">
        
        % for carro in carros:
        <div style="background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); border: 1px solid #eee;">
            <div style="height: 150px; background-color: #ddd; display: flex; align-items: center; justify-content: center; color: #777;">
                <i class="fas fa-car fa-3x"></i>
            </div>
            
            <div style="padding: 15px;">
                <h3 style="margin: 0 0 10px 0; color: #333;">{{carro.modelo}} <small style="color: #777; font-weight: normal;">{{carro.marca}}</small></h3>
                
                <p style="margin: 5px 0; font-size: 14px; color: #555;">
                    <i class="fas fa-calendar"></i> {{carro.ano}} &nbsp;&nbsp; 
                    <i class="fas fa-tachometer-alt"></i> {{carro.quilometragem}} km
                </p>
                
                <div style="margin-top: 15px; display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-size: 18px; font-weight: bold; color: #27ae60;">
                        R$ {{carro.preco_diaria}}<small>/dia</small>
                    </span>
                    <button onclick="alert('Funcionalidade de aluguel será implementada em breve!')" 
                            style="background-color: #3498db; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer;">
                        Alugar
                    </button>
                </div>
            </div>
        </div>
        % end

        % if not carros:
        <div style="grid-column: 1/-1; text-align: center; padding: 40px; color: #777;">
            <h3>Nenhum veículo disponível no momento.</h3>
        </div>
        % end

    </div>
</section>