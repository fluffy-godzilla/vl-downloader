export enum EnvironmentEnum {
  CONFIG_PATH = 'CONFIG_PATH',
  FE_PATH = 'FE_PATH',
  DOWNLOADS_PATH = 'DOWNLOADS_PATH',
  REDIS_HOST = 'REDIS_HOST',
  REDIS_PORT = 'REDIS_PORT',
  // these need to be set when DOWNLOADS_PATH is the root of the ps3netsrv download server and you want
  // to download and extract playstation-related archives
  DIR_IS_NETSRV = 'DIR_IS_NETSRV', // boolean, false by default, used with ps3netsrv
  DL_DECRYPTED_ISO = 'DL_DECRYPTED_ISO', // boolean, false by default, set to true if you wish to download decrypted PS3 ISOs
  EXTRACT_DL_ARCHIVE = 'EXTRACT_DL_ARCHIVE', // boolean, false by default, set to true if you want to extract 7z archive after download
  RENAME_EXTRACTED_ISO = 'RENAME_EXTRACTED_ISO', // boolean, false by default, set to true if you want to rename extracted ISO to include game serial number
}
