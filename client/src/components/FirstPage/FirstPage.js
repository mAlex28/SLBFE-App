import { Card, CardContent, Container, Typography } from '@material-ui/core';
import React from 'react'
import 'react-slideshow-image/dist/styles.css'

const FirstPage = () => {
    const user = JSON.parse(localStorage.getItem('profile'));


    return (
        <Container>
            <Card elevation={5}>
                <CardContent>
                    <Typography variant="h3" component="h3">
                        {!user ? 'Please Login Or Register!' : 'Happy Searching..'}
                    </Typography>
                </CardContent>
            </Card>
        </Container>
    )
}

export default FirstPage