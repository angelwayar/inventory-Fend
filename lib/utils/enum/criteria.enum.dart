enum CriteriaType {
  code,
  supplier,
  brand,
  year,
  description,
  nothing;

  String text() {
    switch (this) {
      case code:
        return 'Código';
      case supplier:
        return 'Proveedor';
      case brand:
        return 'Marca';
      case year:
        return 'Año';
      case description:
        return 'Descripción';
      case nothing:
        return 'Ninguno';
      default:
        return 'Niguno';
    }
  }

  String? queryText() {
    switch (this) {
      case code:
        return 'CODE';
      case supplier:
        return 'SUPPLIER';
      case brand:
        return 'BRAND';
      case year:
        return 'YEAR';
      case description:
        return 'DESCRIPTION';
      case nothing:
        return null;
      default:
        return null;
    }
  }
}
