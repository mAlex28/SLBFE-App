import React, { useEffect, useState } from 'react';
import { useDispatch } from 'react-redux';
import { useHistory } from 'react-router-dom';
import {
    Avatar,
    Button,
    Paper,
    Grid,
    Typography,
    Container,
    TextField
} from '@material-ui/core';
import ChipInput from 'material-ui-chip-input';

import LockOutlinedIcon from '@material-ui/icons/LockOutlined';
import FileBase from 'react-file-base64'

import Input from './Input'
import { signin, signup } from '../../actions/authCitizens'

const initialState = {
    nic: '',
    profilePic: '',
    firstName: '',
    lastName: '',
    age: '',
    description: '',
    contact: '',
    address: '',
    postalCode: '',
    city: '',
    province: '',
    latitude: '',
    longitude: '',
    email: '',
    profession: '',
    qualifications: [],
    birthCertificate: '',
    cv: '',
    passport: '',
    password: '',
    confirmPassword: '',
}

const SignUp = () => {
    const [form, setForm] = useState(initialState)
    const [isSignup, setIsSignup] = useState(false)
    const [showPassword, setShowPassword] = useState(false)
    const [isError, setIsError] = useState(false)
    const handleShowPassword = () => setShowPassword(!showPassword)
    const dispatch = useDispatch()
    const history = useHistory()

    var options = {
        enableHighAccuracy: true,
        timeout: 5000,
        maximumAge: 0,
    }

    const onLocationAccessSucces = (position) => {
        setForm({
            ...form,
            latitude: position.coords.latitude,
            longitude: position.coords.longitude,
        })
        setIsError(false)
    }

    const onLocationAccessError = (error) => {
        console.warn(`ERROR(${error.code}): ${error.message}`)
        setIsError(true)
    }

    useEffect(() => {
        if (isSignup) {
            if (navigator.geolocation) {
                navigator.permissions.query({ name: 'geolocation' }).then((result) => {
                    if (result.state === 'granted') {
                        console.log(result.state)
                        navigator.geolocation.getCurrentPosition(onLocationAccessSucces)
                    } else if (result.state === 'prompt') {
                        navigator.geolocation.getCurrentPosition(
                            onLocationAccessSucces,
                            onLocationAccessError,
                            options
                        )
                    } else if (result.state === 'denied') {
                        setIsError(true)
                    }
                    result.onchange = () => {
                        console.log(result.state)
                    }
                })
            }
        }
    }, [isSignup])

    const switchMode = () => {
        setForm(initialState)
        setIsSignup((prevIsSignup) => !prevIsSignup)
        setShowPassword(false)
    }

    const handleSubmit = (e) => {
        e.preventDefault()

        if (isSignup) {
            if (!isError) {
                setIsError(false)

                dispatch(signup(form, history))
            } else {
                setIsError(true)
            }
        } else {
            dispatch(signin(form, history))
        }
    }

    const handleChange = (e) =>
        setForm({ ...form, [e.target.name]: e.target.value })

    const handleAddChip = (tag) => setForm({ ...form, qualifications: tag });

    const handleDeleteChip = (chipToDelete) => setForm({ ...form, qualifications: form.qualifications.filter((tag) => tag !== chipToDelete) });

    return (
        <Container component="main" maxWidth={isSignup ? 'lg' : 'xs'}>
            <Paper
                style={{
                    marginTop: '50px',
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: 'center',
                    padding: '20px',
                }}
                elevation={6}
            >
                {isError && (
                    alert('Please enable location to login')
                )}
                <Avatar
                    style={{
                        margin: '10px',
                        backgroundColor: '#90caf9',
                    }}
                >
                    <LockOutlinedIcon />
                </Avatar>
                <Typography component="h1" variant="h5">
                    {isSignup ? 'Citizen Sign up' : 'Citizen Sign in'}
                </Typography>

                <form
                    autoComplete="off"
                    onSubmit={handleSubmit}
                    style={{
                        width: '100%', // Fix IE 11 issue.
                        marginTop: '10px',
                    }}
                >
                    <Grid container spacing={2}>
                        {isSignup && (
                            <>
                                <Input
                                    name="firstName"
                                    label="First Name"
                                    handleChange={handleChange}
                                    autoFocus
                                    half
                                />
                                <Input
                                    name="lastName"
                                    label="Last Name"
                                    handleChange={handleChange}
                                    half
                                />
                                <Input
                                    name="nic"
                                    label="NIC (eg:790029871V)"
                                    handleChange={handleChange}
                                    autoFocus
                                    half
                                />
                                <Input
                                    name="age"
                                    label="Age"
                                    handleChange={handleChange}
                                    autoFocus
                                    type="number"
                                    half
                                />
                                <Input
                                    name="contact"
                                    label="Contact (0XX-XXX-XXXX)"
                                    type="number"
                                    handleChange={handleChange}
                                    autoFocus
                                    half
                                />
                                <Input
                                    type="number"
                                    name="postalCode"
                                    label="Postal Code"
                                    handleChange={handleChange}
                                    autoFocus
                                    half
                                />
                                <Input
                                    name="address"
                                    label="Street address"
                                    handleChange={handleChange}
                                    autoFocus
                                />
                                <Input
                                    name="city"
                                    label="City"
                                    handleChange={handleChange}
                                    autoFocus
                                    half
                                />
                                <Input
                                    name="province"
                                    label="Province"
                                    handleChange={handleChange}
                                    autoFocus
                                    half
                                />
                                <Input
                                    name="profession"
                                    label="Profession eg: Software Engineer"
                                    handleChange={handleChange}
                                    autoFocus
                                />
                                <Grid item xs={12} sm={12}>
                                    <TextField
                                        id="outlined-multiline-static"
                                        label="Description"
                                        name="description"
                                        multiline
                                        required
                                        placeholder="Write something about you"
                                        minRows={4}
                                        fullWidth
                                        onChange={handleChange}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={12}>
                                    <ChipInput
                                        fullWidth
                                        style={{ margin: '10px 0' }}
                                        onAdd={(chip) => handleAddChip(chip)}
                                        onDelete={(chip) => handleDeleteChip(chip)}
                                        label="Qualifications"
                                        variant="outlined"
                                    />
                                </Grid>
                            </>
                        )}
                        <Input
                            name="email"
                            label="Email Address"
                            handleChange={handleChange}
                            type="email"
                        />
                        {isSignup ? (
                            <Input
                                name="password"
                                label="Password"
                                handleChange={handleChange}
                                type={showPassword ? 'text' : 'password'}
                                handleShowPassword={handleShowPassword}
                                half
                            />
                        ) : (
                            <Input
                                name="password"
                                label="Password"
                                handleChange={handleChange}
                                type={showPassword ? 'text' : 'password'}
                                handleShowPassword={handleShowPassword}
                            />
                        )}

                        {isSignup && (
                            <>
                                <Input
                                    name="confirmPassword"
                                    label="Repeat Password"
                                    handleChange={handleChange}
                                    type="password"
                                    half
                                />

                                <div
                                    style={{
                                        padding: '15px 15px',
                                    }}
                                >
                                    <label>Upload a profile picture</label> <br />
                                    <FileBase
                                        type="file"
                                        multiple={false}
                                        onDone={({ base64 }) => {
                                            setForm({ ...form, profilePic: base64 })
                                        }}
                                    />
                                </div>
                                <div
                                    style={{
                                        padding: '15px 15px',
                                    }}
                                >
                                    <label>Upload Birth Certificate</label> <br />
                                    <FileBase
                                        type="file"
                                        multiple={false}
                                        onDone={({ base64 }) => {
                                            setForm({ ...form, birthCertificate: base64 })
                                        }}
                                    />
                                </div>
                                <div
                                    style={{
                                        padding: '15px 15px',
                                    }}
                                >
                                    <label>Upload CV</label> <br />
                                    <FileBase
                                        type="file"
                                        multiple={false}
                                        onDone={({ base64 }) => {
                                            setForm({ ...form, cv: base64 })
                                        }}
                                    />
                                </div>
                                <div
                                    style={{
                                        padding: '15px 15px',
                                    }}
                                >
                                    <label>Upload a Passport Photo</label> <br />
                                    <FileBase
                                        type="file"
                                        multiple={false}
                                        onDone={({ base64 }) => {
                                            setForm({ ...form, passport: base64 })
                                        }}
                                    />
                                </div>
                            </>
                        )}
                    </Grid>
                    <Button
                        type="submit"
                        fullWidth
                        variant="contained"
                        color="primary"
                        style={{
                            margin: '20px 0',
                        }}
                    >
                        {isSignup ? 'Sign Up' : 'Sign In'}
                    </Button>

                    <Grid container justifyContent="flex-end">
                        <Grid item>
                            <Button onClick={switchMode}>
                                {isSignup
                                    ? 'Already have an account? Sign in'
                                    : "Don't have an account? Sign Up"}
                            </Button>
                            <Button onClick={() => history.push('/auth')}>
                                Login As Officer
                            </Button>
                        </Grid>
                    </Grid>
                </form>
            </Paper>
        </Container>
    )
}

export default SignUp