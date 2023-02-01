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

    if ((String(apiKey).length > 0) && (environment == 'demo' || environment == 'production')) {
      // Initialize Remita API with apiKey and environment
      this.apiKey = apiKey
      this.nativeRemita.init(apiKey, environment)
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

	pay = ({
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
	}

}

export default new Remita()
