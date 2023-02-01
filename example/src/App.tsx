import * as React from 'react';

import { StyleSheet, View, Text, Button } from 'react-native';
import Remita from 'react-native-remita';

export default function App() {
  React.useEffect(() => {
    Remita.init({
      apiKey: "QzAwMDAxOTUwNjl8NDMyNTkxNjl8ZTg0MjI2MDg4MjU0NzA2NTY2MTYwNGU1NjNiMjUzYjk4ZDQwZjljZGFiMTVmYTljMDUwMGQ0MDg2MjIyYjEyNTA1ZTE2MTMxNmE3ZjM1OTZmYmJkOTE2MTRiY2NmZTY5NTM4MGQ2MDBlZGJlZmM2ODc2YTc2M2M4MjgyZmFjODc=",
      environment: 'demo'
    })
  }, []);

  const payPressed = () => {
    Remita.pay({
      amount: 1000,
      email: "babs@babs.dev",
      phone: "+2349031863448",
      firstName: "Babalola",
      lastName: "Macaulay",
      currencyCode: "NGN",
      narration: "Test payment for this example",
      paymentCompleted: (paymentResponse) => {
        console.log("Payment completed", paymentResponse)
      }
    })
  }

  return (
    <View style={styles.container}>
      <Button
        onPress={() => payPressed()}
        title={'Pay Now'}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  }
});
