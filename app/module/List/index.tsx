import React, {useEffect, useState} from 'react';
import {NativeModules, Text, View} from 'react-native';
import {styles} from './style';
interface Contact {
  name: string;
  number: string;
  familyName: string;
}
const List = () => {
  const [details, setDetails] = useState<Contact | []>([]);
  useEffect(() => {
    NativeModules.Contact.getContact((value: any) => {
      setDetails(value);
    });
  }, []);
  return (
    <View style={styles.container}>
      {details.map((item: Contact) => {
        return (
          <View style={styles.list}>
            <Text>
              Name: {item.name} {item.familyName}{' '}
            </Text>
            <Text>Number : {item.number}</Text>
          </View>
        );
      })}
    </View>
  );
};

export default List;
