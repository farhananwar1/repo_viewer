import 'dart:developer';

import 'package:repo_viewer/app/app.locator.dart';
import 'package:repo_viewer/services/api.dart';
import 'package:repo_viewer/ui/home/home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final navigationService = stackedLocator<NavigationService>();
  final _api = stackedLocator<Api>();
  List repoList = [];

  final json = {
    "CollectionName": "SupportBugs",
    "SubcollectionOf": null,
    "Path": "/SupportBugs",
    "DocumentId": "RandomId",
    "Document": {
      "userDescription": {
        "dataType": "object",
        "description": "",
        "map": {
          "summary": {
            "dataType": "string",
            "example": "",
            "validation": "",
            "description": "One liner summary?"
          },
          "howIsItUseful": {
            "dataType": "string",
            "example": "",
            "validation": "",
            "description": "How is it useful?"
          }
        }
      },
      "systemLogs": {
        "dataType": "object",
        "map": {
          "phoneMake": {
            "dataType": "string|null",
            "example": "Samsung|Apple",
            "description": "dffgdbdfdfd"
          },
          "phoneModel": {
            "dataType": "string|null",
            "example": "iPhone X",
            "description": "Model of mobile phone"
          },
          "phoneOS": {
            "dataType": "string|null",
            "example": "iOS 15.1 | Android 10.2",
            "description": "OS"
          },
          "appBuild": {
            "dataType": "string|null",
            "example": "",
            "description": "App build version"
          },
          "locationPermissionGranted": {
            "dataType":
                "enum(granted|denied|restricted|limited|permanentlyDenied)",
            "example": "granted",
            "description": "The location permission status"
          },
          "picturePermissionGranted": {
            "dataType":
                "enum(granted|denied|restricted|limited|permanentlyDenied)",
            "example": "granted",
            "description": "The picture permission status"
          },
          "bluetoothPermissionGranted": {
            "dataType":
                "enum(granted|denied|restricted|limited|permanentlyDenied)",
            "example": "granted",
            "description": "The bluetooth permission status"
          },
          "accessContactsPermissionGranted": {
            "dataType":
                "enum(granted|denied|restricted|limited|permanentlyDenied)",
            "example": "granted",
            "description": "The contacts permission status"
          },
          "ahaId": {
            "dataType": "string|null",
            "example": "",
            "description": "Corresponding idea id in Aha."
          },
          "ahaStatus": {
            "dataType": "string|null",
            "example": "",
            "description": "Status in Aha,"
          },
          "ahaLastSync": {
            "dataType": "timestamp|null",
            "example": "",
            "description": "When did the last sync happen?"
          }
        }
      },
      "screenshots": {
        "dataType": "array",
        "element": {
          "dataType": "string",
          "example": "/234324sf234werewrxd3.png",
          "validation": "Should be an address to an image in storage.",
          "description": ""
        }
      },
      "documentInfo": {
        "type": "object",
        "map": {
          "deletedBy": {
            "type": "reference|null",
            "referenceCollection": "~Users",
            "example": "/Users/sxvv23rvvfef24r2vfcv"
          },
          "deletedOn": {
            "type": "timestamp|null",
            "example": "2023-01-23 18:00:00"
          },
          "createdBy": {
            "type": "reference|null",
            "referenceCollection": "~Users",
            "example": "/Users/sxvv23rvvfef24r2vfcv"
          },
          "createdOn": {
            "type": "timestamp|null",
            "example": "2023-01-23 18:00:00"
          },
          "archivedBy": {
            "type": "reference|null",
            "referenceCollection": "~Users",
            "example": "/Users/sxvv23rvvfef24r2vfcv"
          },
          "archivedOn": {
            "type": "timestamp|null",
            "example": "2023-01-23 18:00:00"
          },
          "modifiedBy": {
            "type": "reference|null",
            "referenceCollection": "~Users",
            "example": "/Users/sxvv23rvvfef24r2vfcv"
          },
          "modifiedOn": {
            "type": "timestamp|null",
            "example": "2023-01-23 18:00:00"
          }
        }
      }
    },
    "Subcollections": []
  };

  final users = {
    "CollectionName": "Users",
    "SubcollectionOf": null,
    "Path": "/Users",
    "DocumentId": "GoogleAuthId",
    "Document": {
      "username": {
        "dataType": "string",
        "example": "sohail10",
        "validation":
            "Should must be unique, not contain special chars and atleast contain 3 chars. Need consideration of max limit.",
        "description": "Supposed to be set by backend only."
      },
      "marketingGroups": {
        "dataType": "array",
        "element": {
          "dataType": "reference",
          "referenceCollection": "~MarketingGroups",
          "example": "/MarketingGroups/sxvv23rvvfef24r2vfcv"
        }
      },
      "relatedAccounts": {
        "dataType": "array",
        "element": {
          "dataType": "object",
          "map": {
            "name": {
              "dataType": "string",
              "example": "Airport Montreal",
              "validation": ""
            },
            "id": {
              "dataType": "reference",
              "referenceCollection": "~Accounts",
              "example": "/Accounts/sxvv23rvvfef24r2vfcv"
            }
          }
        }
      },
      "customAuthRoles": {
        "dataType": "array",
        "element": {
          "dataType": "string",
          "item": {
            "dataType": "string",
            "example": "electedOfficial",
            "validation": ""
          }
        }
      },
      "electedOfficialId": {
        "dataType": "reference|null",
        "referenceCollection": "~ElectedOfficals",
        "example": "/ElectedOfficals/sxvv23rvvfef24r2vfcv",
        "validation":
            "Should only exist if user is an active elected official.",
        "description": ""
      },
      "electoralCandidateId": {
        "version": 0,
        "dataType": "null",
        "referenceCollection": "",
        "example": "",
        "description": "Will add more detail soon."
      },
      "hsId": {
        "dataType": "string|null",
        "example": "1232441",
        "validation": "The id of the user in hubspot",
        "description": ""
      },
      "myGovernments": {
        "dataType": "object",
        "map": {
          "country": {
            "dataType": "object",
            "map": {
              "id": {
                "dataType": "reference|null",
                "referenceCollection": "~Governments",
                "example": "/Governments/sxvv23rvvfef24r2vfcv"
              },
              "username": {
                "dataType": "string|null",
                "example": "",
                "validation": "",
                "description": ""
              },
              "displayName": {
                "dataType": "object|null",
                "map": {
                  "fr": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  },
                  "en": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  }
                }
              }
            }
          },
          "stateProvince": {
            "dataType": "object",
            "map": {
              "id": {
                "dataType": "reference|null",
                "referenceCollection": "~Governments",
                "example": "/Governments/sxvv23rvvfef24r2vfcv"
              },
              "username": {
                "dataType": "string|null",
                "example": "",
                "validation": "",
                "description": ""
              },
              "displayName": {
                "dataType": "object|null",
                "map": {
                  "fr": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  },
                  "en": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  }
                }
              }
            }
          },
          "city": {
            "dataType": "object",
            "map": {
              "id": {
                "dataType": "reference|null",
                "referenceCollection": "~Governments",
                "example": "/Governments/sxvv23rvvfef24r2vfcv"
              },
              "username": {
                "dataType": "string|null",
                "example": "",
                "validation": "",
                "description": ""
              },
              "displayName": {
                "dataType": "object|null",
                "map": {
                  "fr": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  },
                  "en": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  }
                }
              }
            }
          }
        }
      },
      "myElectoralDistricts": {
        "dataType": "object",
        "map": {
          "country": {
            "dataType": "object",
            "map": {
              "id": {
                "dataType": "reference|null",
                "referenceCollection": "~ElectoralDistricts",
                "example": "/ElectoralDistricts/sxvv23rvvfef24r2vfcv"
              },
              "username": {
                "dataType": "string|null",
                "example": "",
                "validation": "",
                "description": ""
              },
              "displayName": {
                "dataType": "object|null",
                "map": {
                  "fr": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  },
                  "en": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  }
                }
              }
            }
          },
          "stateProvince": {
            "dataType": "object",
            "map": {
              "id": {
                "dataType": "reference|null",
                "referenceCollection": "~ElectoralDistricts",
                "example": "/ElectoralDistricts/sxvv23rvvfef24r2vfcv"
              },
              "username": {
                "dataType": "string|null",
                "example": "",
                "validation": "",
                "description": ""
              },
              "displayName": {
                "dataType": "object|null",
                "map": {
                  "fr": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  },
                  "en": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  }
                }
              }
            }
          },
          "city": {
            "dataType": "object",
            "map": {
              "id": {
                "dataType": "reference|null",
                "referenceCollection": "~ElectoralDistricts",
                "example": "/ElectoralDistricts/sxvv23rvvfef24r2vfcv"
              },
              "username": {
                "dataType": "string|null",
                "example": "",
                "validation": "",
                "description": ""
              },
              "displayName": {
                "dataType": "object|null",
                "map": {
                  "fr": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  },
                  "en": {
                    "dataType": "string|null",
                    "example": "",
                    "validation": "",
                    "description": ""
                  }
                }
              }
            }
          }
        }
      },
      "socials": {
        "dataType": "object",
        "map": {
          "facebook": {
            "dataType": "string|null",
            "example": "",
            "validation": ""
          },
          "instagram": {
            "dataType": "string|null",
            "example": "",
            "validation": ""
          },
          "linkedin": {
            "dataType": "string|null",
            "example": "",
            "validation": ""
          },
          "snapchat": {
            "dataType": "string|null",
            "example": "",
            "validation": ""
          },
          "twitter": {
            "dataType": "string|null",
            "example": "",
            "validation": ""
          },
          "tiktok": {"dataType": "string|null", "example": "", "validation": ""}
        }
      },
      "userMadePublicInfo": {
        "dataType": "object",
        "map": {
          "firstName": {
            "dataType": "string|null",
            "example": "Sohail",
            "validation": ""
          },
          "lastName": {
            "dataType": "string|null",
            "example": "Rauf",
            "validation": ""
          },
          "phoneNumbers": {
            "dataType": "array",
            "element": {
              "dataType": "object",
              "map": {
                "number": {"dataType": "string", "example": ""},
                "extension": {"dataType": "string|null", "example": ""},
                "type": {"dataType": "enum(personal|office)", "example": ""},
                "isValidated": {"dataType": "boolean", "example": ""},
                "isPrimary": {"dataType": "boolean", "example": ""}
              }
            }
          },
          "emails": {
            "dataType": "array",
            "element": {
              "dataType": "object",
              "map": {
                "email": {
                  "dataType": "string",
                  "example": "",
                  "validation": "Must be a valid email address."
                },
                "type": {"dataType": "enum(personal|office)", "example": ""},
                "isValidated": {"dataType": "boolean", "example": ""},
                "isPrimary": {"dataType": "boolean", "example": ""}
              }
            }
          },
          "gender": {
            "dataType": "enum(male|female|other)|null",
            "example": "male",
            "validation": ""
          },
          "streetAddressCordinates": {
            "dataType": "geopoint|null",
            "example": "[125.6, 10.1]",
            "validation": "Should be a valid geopoint."
          },
          "addressText": {
            "dataType": "string|null",
            "example":
                "Street abulasphani, Gulshan-e-Iqbal, Karachi, Sindh, Pakistan",
            "validation": ""
          },
          "bio": {
            "dataType": "string|null",
            "example": "",
            "validation": "",
            "description": ""
          }
        }
      },
      "analytics": {
        "dataType": "object",
        "map": {
          "following": {
            "dataType": "integer",
            "example": "215",
            "validation":
                "Should not be a negative number. Default should be 0."
          },
          "followers": {
            "dataType": "integer",
            "example": "515",
            "validation":
                "Should not be a negative number. Default should be 0."
          },
          "requests": {
            "dataType": "integer",
            "example": "515",
            "validation":
                "Should not be a negative number. Default should be 0."
          },
          "suggestions": {
            "dataType": "integer",
            "example": "515",
            "validation":
                "Should not be a negative number. Default should be 0."
          },
          "appreciations": {
            "dataType": "integer",
            "example": "515",
            "validation":
                "Should not be a negative number. Default should be 0."
          },
          "questions": {
            "dataType": "integer",
            "example": "515",
            "validation":
                "Should not be a negative number. Default should be 0."
          },
          "unreadMessagesCount": {
            "dataType": "integer",
            "example": "515",
            "validation":
                "Should not be a negative number. Default should be 0."
          }
        }
      },
      "isFlagged": {"dataType": "boolean", "description": "Default to false"},
      "shareableLink": {"dataType": "String", "description": "Set by backend"},
      "documentInfo": {
        "dataType": "object",
        "map": {
          "deletedBy": {
            "dataType": "reference|null",
            "referenceCollection": "~Users",
            "example": "/Users/sxvv23rvvfef24r2vfcv"
          },
          "deletedOn": {
            "dataType": "timestamp|null",
            "example": "2023-01-23 18:00:00"
          },
          "createdBy": {
            "dataType": "reference|null",
            "referenceCollection": "~Users",
            "example": "/Users/sxvv23rvvfef24r2vfcv"
          },
          "createdOn": {
            "dataType": "timestamp|null",
            "example": "2023-01-23 18:00:00"
          },
          "archivedBy": {
            "dataType": "reference|null",
            "referenceCollection": "~Users",
            "example": "/Users/sxvv23rvvfef24r2vfcv"
          },
          "archivedOn": {
            "dataType": "timestamp|null",
            "example": "2023-01-23 18:00:00"
          },
          "modifiedBy": {
            "dataType": "reference|null",
            "referenceCollection": "~Users",
            "example": "/Users/sxvv23rvvfef24r2vfcv"
          },
          "modifiedOn": {
            "dataType": "timestamp|null",
            "example": "2023-01-23 18:00:00"
          }
        }
      }
    },
    "Subcollections": ["Addresses"]
  };
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
