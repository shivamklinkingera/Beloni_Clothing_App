import React, {useState} from 'react';
import ParsedText from 'react-native-parsed-text';
import {View, TouchableOpacity, StatusBar} from 'react-native';
import {KeyboardAwareScrollView} from 'react-native-keyboard-aware-scroll-view';

import {text} from '../../text';
import {theme} from '../../constants';
import {
  setRefreshToken,
  setAccessToken,
} from '../../store/slices/appStateSlice';
import {components} from '../../components';
import {validation} from '../../utils/validation';
import {useAppNavigation, useAppDispatch} from '../../hooks';

const SignIn: React.FC = (): JSX.Element => {
  const navigation = useAppNavigation();
  const dispatch = useAppDispatch();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [rememberMe, setRememberMe] = useState(false);

  const renderStatusBar = () => {
    return (
      <StatusBar
        translucent={true}
        backgroundColor={'transparent'}
        barStyle={'dark-content'}
      />
    );
  };

  const renderHeader = () => {
    return (
      <components.Header title='Sign in' goBack={navigation.canGoBack()} />
    );
  };

  const renderContent = () => {
    return (
      <KeyboardAwareScrollView
        enableOnAndroid={true}
        contentContainerStyle={{
          flexGrow: 1,
          backgroundColor: theme.colors.pastel,
          marginHorizontal: 20,
          marginTop: 10,
          marginBottom: 20,
          paddingVertical: 44,
          justifyContent: 'center',
        }}
      >
        <components.Image
          source={require('./../../assets/images/02.png')}
          style={{
            width: '100%',
            aspectRatio: 0.72,
            position: 'absolute',
          }}
        />
        <View style={{paddingHorizontal: 20}}>
          <text.H1
            style={{
              textAlign: 'center',
              marginBottom: 14,
            }}
          >
            Welcome Back!
          </text.H1>
          <text.T16
            style={{
              marginBottom: 31,
              textAlign: 'center',
              color: theme.colors.textColor,
              textTransform: 'none',
            }}
          >
            Use social networks or your email
          </text.T16>
          <View
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              marginBottom: 30,
              alignSelf: 'center',
            }}
          >
            <components.Facebook
              onPress={() => {
                console.log('Facebook');
              }}
              containerStyle={{
                marginHorizontal: 5,
              }}
            />
            <components.Twitter
              onPress={() => {
                console.log('Twitter');
              }}
              containerStyle={{
                marginHorizontal: 5,
              }}
            />
            <components.Google
              onPress={() => {
                console.log('Google');
              }}
              containerStyle={{
                marginHorizontal: 5,
              }}
            />
          </View>
          <components.InputField
            placeholder='kristinwatson@mail.com'
            onChangeText={(text) => setEmail(text)}
            value={email}
            checkIcon={true}
            containerStyle={{
              marginBottom: 10,
            }}
          />
          <components.InputField
            placeholder='••••••••'
            onChangeText={(text) => setPassword(text)}
            eyeOffIcon={true}
            value={password}
            containerStyle={{
              marginBottom: 20,
            }}
            secureTextEntry={true}
          />
          <View
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              marginBottom: 19,
            }}
          >
            <TouchableOpacity
              style={{flexDirection: 'row', alignItems: 'center'}}
              onPress={() =>
                setRememberMe((rememberMeState) => !rememberMeState)
              }
            >
              <View
                style={{
                  width: 18,
                  height: 18,
                  backgroundColor: theme.colors.white,
                  borderWidth: 1,
                  borderColor: theme.colors.pastel,
                  justifyContent: 'center',
                  alignItems: 'center',
                }}
              >
                {rememberMe && (
                  <View
                    style={{
                      width: 10,
                      height: 10,
                      backgroundColor: theme.colors.accentColor,
                    }}
                  />
                )}
              </View>
              <text.T16
                style={{
                  marginLeft: 10,
                  color: theme.colors.textColor,
                }}
              >
                Remember me
              </text.T16>
            </TouchableOpacity>
            <TouchableOpacity
              style={{marginLeft: 'auto'}}
              onPress={() => navigation.navigate('ForgotPassword')}
            >
              <text.T16 style={{color: theme.colors.accentColor}}>
                Forgot password?
              </text.T16>
            </TouchableOpacity>
          </View>
          <components.Button
            title='Sign in'
            onPress={() => {
              if (validation({email, password})) {
                dispatch(setRefreshToken('refreshToken'));
                dispatch(setAccessToken('accessToken'));
              }
            }}
            containerStyle={{
              marginBottom: 20,
            }}
          />
          <ParsedText
            style={{
              ...theme.fonts.Lato_400Regular,
              fontSize: 16,
              lineHeight: 16 * 1.7,
              color: theme.colors.textColor,
            }}
            parse={[
              {
                pattern: /Register now/,
                style: {color: theme.colors.accentColor},
                onPress: () => navigation.navigate('SignUp'),
              },
            ]}
          >
            No account? Register now.
          </ParsedText>
        </View>
      </KeyboardAwareScrollView>
    );
  };

  return (
    <components.SafeAreaView
      style={{
        backgroundColor: theme.colors.white,
      }}
    >
      {renderStatusBar()}
      {renderHeader()}
      {renderContent()}
    </components.SafeAreaView>
  );
};

export default SignIn;
