import json
import os
from abc import ABC, abstractmethod
#Localização
DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')
#Classe abstrata que serve de base para diversas outras
class Base(ABC):
    def __init__(self, id):
        self.id = id
#Método que transforma em dict
    @abstractmethod
    def to_dict(self):
        pass
#Método que converte de dict, é bem importante na hr de mecher em json
    @classmethod
    @abstractmethod
    def from_dict(cls, data):
        pass
#Parte importante relacionada ao banco de dados do sistema, todas as classe model herdam desse
class BaseModel:
    #Constructor
    def __init__(self, filename, classe_entidade):
        self.file_path = os.path.join(DATA_DIR, filename)
        self.classe_entidade = classe_entidade
        self.data = self._load()
    #Carrega os arquivos indicados pelo caminho, se não existe retorna uma list vazia
    #Arquivo com acesso local apenas
    def _load(self):
        if not os.path.exists(self.file_path):
            return []
        try:
            with open(self.file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                if not content: return []
                data_list = json.loads(content)
                return [self.classe_entidade.from_dict(item) for item in data_list]
        except Exception as e:
            print(f"Erro ao carregar {self.file_path}: {e}")
            return []
    #Salva os arquivos indicados pelo caminho em json
    #Arquivo com acesso local apenas
    def _save(self):
        if not os.path.exists(DATA_DIR):
            os.makedirs(DATA_DIR)
        with open(self.file_path, 'w', encoding='utf-8') as f:
            json.dump([item.to_dict() for item in self.data], f, indent=4, ensure_ascii=False)
    #Pega todo os  arquivos e retorna em data
    def get_all(self):
        self.data = self._load() 
        return self.data
    #pega pelo id no self_load
    def get_by_id(self, entity_id: int):
        self.data = self._load()
        return next((item for item in self.data if item.id == entity_id), None)
    #adiciona o entity(tipo cliente ou locador) e coloca numa lista self.data
    def add(self, entity):
        self.data.append(entity)
        self._save()
    #Atualiza o entity
    def update(self, updated_entity):
        for i, item in enumerate(self.data):
            if item.id == updated_entity.id:
                self.data[i] = updated_entity
                self._save()
                return True
        return False
    #Salva apenas os items diferente do escolhido
    def delete(self, entity_id: int):
        self.data = [item for item in self.data if item.id != entity_id]
        self._save()
#Classe que serve de base para os atributos do Cliente e Locador
class BasePerfil(Base):
    def __init__(self, id, name, email, password, telephone, is_locador):
        super().__init__(id)
        self.name = name
        self.email = email
        self.password = password
        self.telephone = telephone
        self.is_locador = is_locador