import json
import os
from models.vehicles import Vehicle

DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

class Locador:
    def __init__(self, id, name, email, password, telephone, is_locador, cnpj, veiculos : list):
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.telephone = telephone
        self.is_locador = is_locador
        self.cnpj = cnpj
        self.veiculos = veiculos if veiculos else []

    def __repr__(self):
        return (f"Locador(id={self.id}, name='{self.name}', email='{self.email}',"
                f"password='{self.password}', telephone='{self.telephone}',"
                f"is_locador='{self.is_locador}', cnpj='{self.cnpj}',"
                f"veiculos='{self.veiculos}'")

    def to_dict(self):
        veiculos_list = []
        for v in self.veiculos:
            if hasattr(v, 'to_dict'):
                veiculos_list.append(v.to_dict())
            else:
                veiculos_list.append(v)
                
    @classmethod
    def from_dict(cls, data):
        veiculos_objs = []
        if data.get('veiculos'):
            for item in data['veiculos']:
                veiculos_objs.append(Vehicle.from_dict(item))
                
class LocadorModel:
    FILE_PATH = os.path.join(DATA_DIR, 'locador.json')
    
    def __init__(self):
        self.locadores = self._load()
  
    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        try:
            with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
                content = f.read()
                if not content: return []
                data = json.loads(content)
                return [Locador.from_dict(item) for item in data]
        except Exception as e:
            print(f"Erro ao ler locador.json: {e}")
            return []

    def _save(self):
        if not os.path.exists(DATA_DIR):
            os.makedirs(DATA_DIR)
            
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([l.to_dict() for l in self.locadores], f, indent=4, ensure_ascii=False)

    def get_all(self):
        return self.locadores

    def get_by_id(self, locador_id: int):
        return next((l for l in self.locadores if l.id == locador_id), None)

    def add_locador(self, locador: Locador):
        self.locadores.append(locador)
        self._save()

    def update_locador(self, updated_locador: Locador):
        for i, locador in enumerate(self.locadores):
            if locador.id == updated_locador.id:
                self.locadores[i] = updated_locador
                self._save()
                break