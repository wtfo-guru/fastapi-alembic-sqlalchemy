import typing as ty

from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import as_declarative

KCHARS30 = 30
KCHARS39 = 39
KCHARS256 = 256

class_registry: ty.Dict = {}  # type: ignore [type-arg]


@as_declarative(class_registry=class_registry)
class Base:
    id: ty.Any
    __name__: str

    # Generate __tablename__ automatically
    @declared_attr
    def __tablename__(cls) -> str:  # noqa: N805 first argument self
        return cls.__name__.lower()
