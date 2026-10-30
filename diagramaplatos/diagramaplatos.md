# Sistema de Gestión de Platos e Ingredientes

A continuación se detalla el diseño de la base de datos para la gestión del menú, categorías e ingredientes.

## 1. Modelo Relacional (Tablas)

| categoria |
| :--- |
| **idCategoria (PK)** |
| nombre |
| descripcion |
| encargado |

| plato |
| :--- |
| **idPlato (PK)** |
| foto |
| precio final |
| nivel de dificultad |
| nombre |
| descripcion |

| plato_ingrediente |
| :--- |
| *idPlato (FK)* |
| *idIngrediente (FK)* |
| cantidad |
| unidadMedida |

| ingredientes |
| :--- |
| **idIngredientes (PK)** |
| cantidadActualAlmacen |
| nombre |

---

## 2. Modelo Entidad-Relación (Diagrama)

![Diagrama Entidad-Relación](./diagrama_platos.svg)

---

## 3. Reglas de Negocio y Cardinalidades
*   **Plato - Categoría (1:N):** Un plato **pertenece** obligatoriamente a una única categoría (1,1), mientras que una categoría puede englobar a uno o muchos platos (1,n).
*   **Plato - Ingrediente (M:N):** Un plato **contiene** muchos ingredientes y un ingrediente puede formar parte de muchos platos (n,m). 
*   **Atributos de Relación:** Los atributos `cantidad` y `unidad de medida` se sitúan en la relación de intersección (`contiene`), ya que dependen de la combinación específica de un plato y un ingrediente concreto.
