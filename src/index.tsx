import { NativeModules, Platform } from 'react-native';

interface PaymentCompletedResponse {
  "paymentResponseData": {
    "amount": String,
    "message": String,
    "paymentReference": String,
    "processorId": String,
    "transactionId": String,
  },
  "responseCode": String,
  "responseMessage": String,
}

class Remita {
  protected nativeRemita = NativeModules.Remita ?? new Proxy(
    {},
    {
      get() {
        throw new Error(`The package 'react-native-remita' doesn't seem to be linked. Make sure: \n\n` +
        Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
        '- You rebuilt the app after installing the package\n' +
        '- You are not using Expo Go\n');
      },
    }
  );

  protected apiKey: String = ''
  protected initialized: boolean = false
  protected environment: String = 'demo'

	init = ({
		apiKey,
    environment = 'demo'
	}: {
		apiKey: String,
    environment?: 'demo' | 'production'
	}) => {

    console.log("Available native properties", this.nativeRemita)

    if ((String(apiKey).length > 0) && (environment == 'demo' || environment == 'production')) {
      // Initialize Remita API with apiKey and environment
      if(Platform.OS == 'android') {
        this.nativeRemita.init(apiKey, environment)
      }
      this.apiKey = apiKey
      this.initialized = true
    } else {
      throw new Error("To initialize remita payment correctly, make sure you are calling init() and passing passing a correct apiKey with environment as 'demo' or 'production'.");
    }
	}

  protected checkInitialized = () => {
    if (!this.initialized) {
      console.log("Remita module not initialized yet")
      throw new Error("To initialize remita payment, you need to call init() first.");
    }
  }

	pay = async ({
    amount,
    email,
    phone,
    firstName,
    lastName,
    currencyCode,
    narration,
    transactionId = (Math.floor((Math.random() * 1000000000) + 1)).toString(),
    paymentCompleted
  }: {
    amount: Number,
    email: String,
    phone: String,
    firstName: String,
    lastName: String,
    currencyCode: String,
    narration: String,
    transactionId?: String,
    paymentCompleted: (paymentResponse: PaymentCompletedResponse) => void
  }) => {
    this.checkInitialized()

    if (Platform.OS == 'android') {
      return this.nativeRemita.pay(
        String(amount),
        email,
        phone,
        firstName,
        lastName,
        currencyCode,
        narration,
        transactionId,
        (paymentResponse: any) => paymentCompleted(paymentResponse)
      )
    } else {
      console.log(`This package is not fully ready on iOS yet. Kindly visit the repository issues page on GitHub https://github.com/devbabs/react-native-remita/issues if you are willing to contribute and assist in making the iOS integration work.`)
      return
    }
	}

}

export default new Remita()
