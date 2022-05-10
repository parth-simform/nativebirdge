import React, {useState} from 'react';
import {
  TouchableOpacity,
  View,
  Text,
  NativeModules,
  Platform,
} from 'react-native';
import DetailInput from '../../component/Input';
import {styles} from './style';

const Home = (props: any) => {
  const [name, setName] = useState('');
  const [lName, setLName] = useState('');
  const [number, setNumbe] = useState('');
  const [email, setEmail] = useState('');

  const onSubmit = async () => {
    try {
      let result = await NativeModules.Contact.createContact(
        name,
        lName,
        number,
        email,
      );
      console.log(result, '545');

      props.navigation.push('List');
    } catch (error) {}
  };
  const onSubmitAndroid = async () => {
    NativeModules.Contact.createContact(name, lName, number, email)
      .then(() => props.navigation.push('List'))
      .catch((e: string) => console.log(e));
  };
  return (
    <View style={styles.container}>
      <DetailInput
        title={'First Name'}
        onChangeText={setName}
        value={name}
        placeholder={'FirstName'}
      />
      <DetailInput
        title={'Last Name'}
        onChangeText={setLName}
        value={lName}
        placeholder={'Last Name'}
      />
      <DetailInput
        title={'Number'}
        onChangeText={setNumbe}
        value={number}
        placeholder={'Enter Number'}
        keyboardType="numeric"
      />
      <DetailInput
        title={'Email'}
        onChangeText={setEmail}
        value={email}
        keyboardType="email-address"
        placeholder={'Enter Email'}
      />

      <TouchableOpacity
        style={styles.btn}
        onPress={Platform.OS === 'ios' ? onSubmit : onSubmitAndroid}>
        <Text style={styles.txt}>Submit Data</Text>
      </TouchableOpacity>
    </View>
  );
};

export default Home;
