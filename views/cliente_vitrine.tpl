% rebase('layout.tpl', title='Veículos Disponíveis')

<section class="users-section" style="padding: 30px;">

    <div class="section-header" 
         style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
        
        <h1 class="section-title" 
            style="font-size: 28px; font-weight: 700; color: #333; display: flex; align-items: center; gap: 10px;">
            <i class="fas fa-car-side" style="color: #3498db;"></i>
            Veículos Disponíveis
        </h1>

        <div style="text-align: right; font-size: 16px; color: #444;">
            <span style="font-weight: 600;">Olá, {{cliente.name}}!</span> |
            <a href="/cliente/perfil" 
               style="color: #3498db; text-decoration: none; font-weight: 600;">Editar Perfil</a>
        </div>
    </div>

    <div style="
        display: grid; 
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); 
        gap: 25px;">
        
        % for carro in carros:

        <div style="
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 18px rgba(0,0,0,0.12);
            border: 1px solid #e9e9e9;
            transition: 0.25s ease;
            animation: fadeIn 0.5s ease;
        "
        onmouseover="this.style.transform='translateY(-6px)'"
        onmouseout="this.style.transform='translateY(0)'">

            <!-- Imagem / Ícone -->
            <div style="
                height: 170px;
                background: linear-gradient(135deg, #dfe9f3, #ffffff);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #777;">
                <i class="fas fa-car fa-4x"></i>
            </div>

            <div style="padding: 18px;">

                <!-- Modelo + Marca -->
                <h3 style="margin: 0 0 12px 0; font-size: 20px; color: #333;">
                    {{carro.modelo}}
                    <small style="color: #777; font-weight: normal; font-size: 14px;">
                        ({{carro.marca}})
                    </small>
                </h3>

                <!-- Ano / Quilometragem -->
                <p style="margin: 5px 0; font-size: 15px; color: #555;">
                    <i class="fas fa-calendar"></i> {{carro.ano}}
                    &nbsp;&nbsp;&nbsp;
                    <i class="fas fa-tachometer-alt"></i> {{carro.quilometragem}} km
                </p>

                <!-- Preço + Ação -->
                <div style="
                    margin-top: 18px; 
                    display: flex; 
                    justify-content: space-between; 
                    align-items: center;">

                    <span style="font-size: 20px; font-weight: 700; color: #27ae60;">
                        R$ {{carro.preco_diaria}}
                        <small style="color: #777;">/dia</small>
                    </span>

                    <button onclick="alert('Funcionalidade de aluguel será implementada em breve!')" 
                        style="
                            background-color: #3498db;
                            color: white;
                            border: none;
                            padding: 10px 18px;
                            border-radius: 6px;
                            cursor: pointer;
                            font-size: 15px;
                            font-weight: 600;
                            transition: 0.25s ease;
                        "
                        onmouseover="this.style.background='#217dbb'"
                        onmouseout="this.style.background='#3498db'">
                        Alugar
                    </button>

                </div>

            </div>
        </div>

        % end


        % if not carros:
        <div style="
            grid-column: 1 / -1;
            text-align: center;
            padding: 40px;
            color: #777;
            animation: fadeIn 0.5s ease;">
            <h3 style="font-size: 20px;">Nenhum veículo disponível no momento.</h3>
        </div>
        % end

    </div>
</section>

<style>
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(8px); }
    to   { opacity: 1; transform: translateY(0); }
}
</style>
