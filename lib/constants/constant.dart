class Constant {
  static final bool forceMaterial = false;

  static final String usernameKey = 'user_name';

  static final String dbName = 'auto-parts.db';

  //Parts firebase configurations
  static final String partsCollection = 'parts';
  static final int partsLimit = 5;
  static final String initialSort = 'modified';

  //Services firebase configurations
  static final String servicesCollection = 'services';
  static final int servicesLimit = 5;
  static final String serviceInitialSort = 'modified';

  //Meta data firebase configurations
  static final String metaDataCollection = 'meta-data';
  static final String metaDataKey = 'meta-data';
  static final String serviceCatKey = 'serviceCategories';

  //Google maps config
  static final double initialZoom = 15;
}
