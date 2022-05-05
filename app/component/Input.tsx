import React from 'react';
import {StyleSheet, Text, TextInput, View} from 'react-native';

const DetailInput = (props: any) => {
  return (
    <View style={styles.container}>
      <View style={{width: 80, alignItems: 'flex-start'}}>
        <Text style={styles.txt}>{props.title} : </Text>
      </View>
      <TextInput
        style={styles.input}
        onChangeText={props.onChangeText}
        value={props.value}
        placeholder={props.placeholder}
        {...props}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    width: 350,
    alignItems: 'center',
    marginHorizontal: 10,
  },
  txt: {
    color: 'red',
  },
  input: {
    height: 40,
    margin: 12,
    borderWidth: 1,
    padding: 10,
    width: 250,
  },
});

export default DetailInput;
