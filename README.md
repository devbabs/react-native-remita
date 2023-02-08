# react-native-remita

This React Native module provides a wrapper to add Remita Payments to your React Native application using the Remita [Android Mobile SDK](https://github.com/RemitaNet/remita-android) and the Remita iOS Mobile SDK libraries.

## TODO (Coming Soon)
- Add Support for iOS

![Android Screenshot for react-native-remita Payment Screen](screenshot.png)

## Installation
This module currently works well on Android 👍🏽

```sh
npm install react-native-remita
```

## Setup
Make sure you call this `Remita.init()` with correct arguments before calling `Remita.pay()`

```js
import Remita from 'react-native-remita';

// ...

Remita.init({
      apiKey: YOUR_REMITA_PUBLIC_KEY, //Replace this with your own Remita Public Key
      environment: 'demo' // demo or production
    })
```
#### Important ⚠️:
###### Demo Setup:
```
{
  'apiKey': TEST_PUBLIC_KEY`,
  'environment': 'demo'
}
```
###### Production Setup:
```
{
  'apiKey': LIVE_PUBLIC_KEY`,
  'environment': 'production'
}
```

## Usage
You can trigger the `Remita.pay()` method when a button is pressed.
Make sure you pass all required parameters to this method call.

```js
Remita.pay({
  amount: 1000,
  email: "example@email.com",
  phone: "+23412345678",
  firstName: "Babalola",
  lastName: "Macaulay",
  currencyCode: "NGN",
  narration: "Test payment for this example",
  paymentCompleted: (paymentResponse) => {
    console.log("Payment completed", paymentResponse)
     // Do whatever you want with `paymentResponse` object
  }
})
```

## Successful payment response
You can trigger the `Remita.pay()` method when a button is pressed.
Make sure you pass all required parameters to this method call.

```js
{
  "paymentResponseData": {
    "amount": "1000.0",
    "message": "",
    "paymentReference": "210010145765",
    "processorId": "",
    "transactionId": "710378586"
  },
  "responseCode": "00",
  "responseMessage": "SUCCESS"
}
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

#### Made with ❤️ by [Babs](https://babs.dev) 👨🏽‍💻😎
#### Cheers 🥂
---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
