import {View, Text, TouchableOpacity} from 'react-native';
import React from 'react';
import type {PropsWithChildren} from 'react';

import {theme} from '../../constants';

type Props = PropsWithChildren<{
  title: string;
  onPress: () => void;
  containerStyle?: object;
  buttonStyle?: object;
  titleStyle?: object;
}>;

const Button: React.FC<Props> = ({
  containerStyle,
  title,
  onPress,
  buttonStyle,
  titleStyle,
}) => {
  return (
    <View style={containerStyle}>
      <TouchableOpacity
        style={{
          width: '100%',
          height: 60,
          backgroundColor: theme.colors.mainColor,
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'center',
          ...buttonStyle,
        }}
        onPress={onPress}
      >
        <Text
          style={{
            textTransform: 'uppercase',
            fontSize: 14,
            textAlign: 'center',
            color: theme.colors.white,
            ...theme.fonts.Lato_400Regular,
            ...titleStyle,
          }}
        >
          {title}
        </Text>
      </TouchableOpacity>
    </View>
  );
};

export default Button;
