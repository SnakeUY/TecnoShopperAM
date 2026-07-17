class CountryData {
  static const List<String> _countries = [
    // América del Norte
    'Canadá',
    'Estados Unidos',
    'México',
    // América Central
    'Belice',
    'Costa Rica',
    'El Salvador',
    'Guatemala',
    'Honduras',
    'Nicaragua',
    'Panamá',
    // Caribe
    'Antigua y Barbuda',
    'Bahamas',
    'Barbados',
    'Cuba',
    'Dominica',
    'Granada',
    'Haití',
    'Jamaica',
    'República Dominicana',
    'San Cristóbal y Nieves',
    'Santa Lucía',
    'San Vicente y las Granadinas',
    'Trinidad y Tobago',
    // América del Sur
    'Argentina',
    'Bolivia',
    'Brasil',
    'Chile',
    'Colombia',
    'Ecuador',
    'Guyana',
    'Paraguay',
    'Perú',
    'Surinam',
    'Uruguay',
    'Venezuela',
  ];

  static const List<String> _canadaProvinces = [
    'Alberta', 'British Columbia', 'Manitoba', 'New Brunswick',
    'Newfoundland and Labrador', 'Northwest Territories', 'Nova Scotia',
    'Nunavut', 'Ontario', 'Prince Edward Island', 'Quebec',
    'Saskatchewan', 'Yukon',
  ];

  static const List<String> _usaStates = [
    'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado',
    'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho',
    'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
    'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
    'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada',
    'New Hampshire', 'New Jersey', 'New Mexico', 'New York',
    'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon',
    'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota',
    'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington',
    'West Virginia', 'Wisconsin', 'Wyoming',
  ];

  static const List<String> _mexicoStates = [
    'Aguascalientes', 'Baja California', 'Baja California Sur', 'Campeche',
    'Chiapas', 'Chihuahua', 'Ciudad de México', 'Coahuila', 'Colima',
    'Durango', 'Guanajuato', 'Guerrero', 'Hidalgo', 'Jalisco',
    'Estado de México', 'Michoacán', 'Morelos', 'Nayarit', 'Nuevo León',
    'Oaxaca', 'Puebla', 'Querétaro', 'Quintana Roo', 'San Luis Potosí',
    'Sinaloa', 'Sonora', 'Tabasco', 'Tamaulipas', 'Tlaxcala',
    'Veracruz', 'Yucatán', 'Zacatecas',
  ];

  static const List<String> _argentinaProvinces = [
    'Buenos Aires', 'Catamarca', 'Chaco', 'Chubut', 'Ciudad de Buenos Aires',
    'Córdoba', 'Corrientes', 'Entre Ríos', 'Formosa', 'Jujuy', 'La Pampa',
    'La Rioja', 'Mendoza', 'Misiones', 'Neuquén', 'Río Negro', 'Salta',
    'San Juan', 'San Luis', 'Santa Cruz', 'Santa Fe', 'Santiago del Estero',
    'Tierra del Fuego', 'Tucumán',
  ];

  static const List<String> _brasilStates = [
    'Acre', 'Alagoas', 'Amapá', 'Amazonas', 'Bahia', 'Ceará',
    'Distrito Federal', 'Espírito Santo', 'Goiás', 'Maranhão',
    'Mato Grosso', 'Mato Grosso do Sul', 'Minas Gerais', 'Pará',
    'Paraíba', 'Paraná', 'Pernambuco', 'Piauí', 'Rio de Janeiro',
    'Rio Grande do Norte', 'Rio Grande do Sul', 'Rondônia', 'Roraima',
    'Santa Catarina', 'São Paulo', 'Sergipe', 'Tocantins',
  ];

  static List<String> getCountries() => _countries;

  static String getSubdivisionTitle(String? country) {
    switch (country) {
      case 'Canadá':         return 'Provincia';
      case 'Argentina':      return 'Provincia';
      case 'Estados Unidos': return 'Estado';
      case 'México':         return 'Estado';
      case 'Brasil':         return 'Estado';
      default:               return '';
    }
  }

  static List<String> getSubdivisionsByCountry(String country) {
    switch (country) {
      case 'Canadá':         return _canadaProvinces;
      case 'Estados Unidos': return _usaStates;
      case 'México':         return _mexicoStates;
      case 'Argentina':      return _argentinaProvinces;
      case 'Brasil':         return _brasilStates;
      default:               return [];
    }
  }

  static List<String> getSubdivisionList(String _) => [];
}
