/* eslint-disable react/self-closing-comp */
import {
  NativeModules,
  SafeAreaView,
  Text,
  View,
  TouchableOpacity,
  Platform,
} from 'react-native';
import React, {useEffect, useState} from 'react';

interface Contact {
  name: string;
  number: string;
}
const App = () => {
  const [details, setDetails] = useState<Contact | []>([]);
  useEffect(() => {
    console.log(NativeModules.Contact.getConstants());

    Platform.OS == 'ios'
      ? NativeModules.Contact.getContact((value: any) => {
          setDetails(value);
          console.log('data is', value);
        })
      : NativeModules.Contact.getContact()
          .then(e => setDetails(e))
          .catch(e => console.error(e));
  }, []);
  return (
    <SafeAreaView
      style={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
      <TouchableOpacity onPress={() => console.log('55')}></TouchableOpacity>
      {details.map((item: Contact) => {
        return (
          <View style={{borderWidth: 1, width: 300, padding: 5}}>
            <Text>Name: {item.name} </Text>
            <Text>Number : {item.number}</Text>
          </View>
        );
      })}
    </SafeAreaView>
  );
};

export default App;
