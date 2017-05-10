import Vue from 'vue'
import VueRouter from 'vue-router'
import Hello from '@/components/Hello'
import Comp1 from '@/components/Comp1'

Vue.use(VueRouter)


const User = {
    name:'root',
    template: `
    <div class="user">
      <h2>User {{ $route.params.id }}</h2>
      <router-view></router-view>
    </div>
  `
}

const UserHome = { template: '<div>Home</div>' }
const UserHome1 = { template: '<div>Homes</div>' }
const UserProfile = { template: '<div>Profile</div>' }
const UserPosts = { template: '<div>Posts</div>' }

// The matching uses path-to-regexp, which is the matching engine used
// by express as well, so the same matching rules apply.
// For detailed rules, see https://github.com/pillarjs/path-to-regexp
const router = new VueRouter({
    routes: [{
            path: '/user/:id',
            name:'root',
            component: User,
            children: [
            {
                path: '',
                name:'child',
                component: {
                    name:'child',
                    template: '<div>1</div>'}
            },
            {
                path: '1',
                name:'child',
                component: {
                    name:'child',
                    template: '<div>2</div>'}
            },
            {
                path: '',
                name:'child',
                component: {
                    name:'child',
                    template: '<div>3</div>'}
            },
            {
                path: '',
                name:'child',
                component: {
                    name:'child',
                    template: '<div>4</div>'}
            }
            ]
        }
    ]
})



export default router